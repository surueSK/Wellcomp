import coremltools

model = coremltools.converters.keras.convert("models/example_model.hdf5")

model.save('t-ubicoustics.mlmodel')
