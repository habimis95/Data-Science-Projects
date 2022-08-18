import numpy as np
def gradient_descent_2(alpha, x, y, numIterations):
    # x = [[1 x0], [1 x1], [1 x2]...]
    m = x.shape[0] # number of samples
    theta = np.ones(2)
    for Iter in range(0, numIterations):
        hypothesis = np.dot(x, theta)
        #hypothesis = theta0 + theta1.x ~ x.dot(theta) ~ (1 x).dot(theta0 theta1)
        loss = hypothesis -y
        J = np.sum(loss ** 2)/(2 * m) # cost
        print("Iter %s | J: %.3f" %(Iter, J))
        theta0_prime = np.sum(loss)/m
        theta1_prime = np.sum(loss*x[:,1])/m
        gradient = np.array([theta0_prime, theta1_prime])
        theta = theta - alpha * gradient # update
    return theta