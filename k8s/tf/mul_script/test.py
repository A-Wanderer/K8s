import tensorflow as tf
import os
import json

strategy = tf.distribute.MultiWorkerMirroredStrategy()
global_batch_size = 128
with strategy.scope():
    model = tf.keras.Sequential([
        tf.keras.layers.Dense(1,
                            input_shape=(1,),
                            kernel_initializer=tf.keras.initializers.Constant(1.0),
                            bias_initializer=tf.keras.initializers.Zeros())
    ])
    optimizer = tf.keras.optimizers.SGD(learning_rate=0.1)

dataset = tf.data.Dataset.from_tensors(
    ([1.], [1.])).repeat(1000).batch(100)
dist_dataset = strategy.experimental_distribute_dataset(dataset)

@tf.function
def train_step(dist_inputs):
    def step_fn(inputs):
        features, labels = inputs

        with tf.GradientTape() as tape:
            logits = model(features, training=True)
            fun = tf.multiply(logits, 2.0, name='multiply')
            loss = tf.reduce_sum(fun) * (1.0 / global_batch_size)

        grads = tape.gradient(loss, model.trainable_variables)
        optimizer.apply_gradients(list(zip(grads, model.trainable_variables)))
        return fun

    per_example_losses = strategy.run(step_fn, args=(dist_inputs, ))
    mean_loss = strategy.reduce(
        tf.distribute.ReduceOp.MEAN,
        per_example_losses,
        axis=0,
    )
    return mean_loss

with strategy.scope():
    for inputs in dist_dataset:
        print(train_step(inputs))