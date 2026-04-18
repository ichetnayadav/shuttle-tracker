from sklearn.linear_model import LinearRegression
import numpy as np
import sys
import json

# Training data
X = np.array([[1,2],[2,4],[3,6],[4,8]])
y = np.array([2,5,7,10])

model = LinearRegression()
model.fit(X, y)

# Get input from frontend
data = json.loads(sys.argv[1])

traffic = data["traffic"]
distance = data["distance"]

prediction = model.predict([[traffic, distance]])

# Send output
print(round(prediction[0], 2))