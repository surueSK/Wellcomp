import numpy as np
array = np.random.randint(1, 1000, 1000)

def bubble_sort(array):
    n = len(array)
    for i in range(n-1):
        for j in range(n-1, i, -1):
            if array[j] < array[j-1]:
                tmp = array[j]
                array[j] = array[j-1]
                array[j-1] = tmp

# デバッグ
if __name__ == "__main__":
  print("before", array)
  bubble_sort(array)
  print("after ", array)
