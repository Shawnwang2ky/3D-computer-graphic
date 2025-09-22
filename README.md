NCU_Course_HW

# Lab 1

## 描述
這是一個小畫家，可以畫直線、多邊形、圓圈、橢圓、曲線、鉛筆以及橡皮擦

### 功能說明
畫直線
![示範jpg](./ComputerGraphics_Yeh-Lab1/image/line.jpg)
畫多邊形
![示範jpg](./ComputerGraphics_Yeh-Lab1/image/poly.jpg)
畫圓
![示範jpg](./ComputerGraphics_Yeh-Lab1/image/circle.jpg)
畫橢圓Markdown
![示範jpg](./ComputerGraphics_Yeh-Lab1/image/circle1.jpg)
畫曲線
![示範jpg](./ComputerGraphics_Yeh-Lab1/image/curve.jpg)
鉛筆
![示範jpg](./ComputerGraphics_Yeh-Lab1/image/heart.jpg)
擦除(滾動滑鼠即可改變擦除範圍)
![示範jpg](./ComputerGraphics_Yeh-Lab1/image/ohno.jpg)

# Lab 2

## 描述
這是一個小畫家，可以畫直線、多邊形、圓圈、橢圓、曲線、鉛筆以及橡皮擦

### 功能說明
畫長方形
![示範jpg](./ComputerGraphics_Yeh-Lab2/image/rec.PNG)
畫星星
![示範jpg](./ComputerGraphics_Yeh-Lab2/image/star.PNG)
影片示範
![示範gif](./ComputerGraphics_Yeh-Lab2/image/video.gif)

# Lab 3

## 描述
這是一個3D小畫家，支援旋轉、平移、縮放，以及移動相機位置。

### 功能說明
Rotation Matrix (Y-axis)
![示範jpg](./ComputerGraphics_Yeh-Lab3/image/1.jpg)
Matrix4::makeRotX(float a)
![示範jpg](./ComputerGraphics_Yeh-Lab3/image/2.jpg)
Model Transformation (Model Matrix)
![示範jpg](./ComputerGraphics_Yeh-Lab3/image/3.jpg)
Camera Transformation (View Matrix)
![示範jpg](./ComputerGraphics_Yeh-Lab3/image/4.jpg)
Perspective Rendering
![示範jpg](./ComputerGraphics_Yeh-Lab3/image/5.jpg)
Depth Buffer
![示範jpg](./ComputerGraphics_Yeh-Lab3/image/6.jpg)
Camera Control
![示範jpg](./ComputerGraphics_Yeh-Lab3/image/7.jpg)
Backculling
![示範jpg](./ComputerGraphics_Yeh-Lab3/image/8.jpg)
影片
![示範gif](./ComputerGraphics_Yeh-Lab3/image/9.gif)

# Lab 4

## 描述
完成三角形的Barycentric Coordinates、Flat Shading、Gouraud著色、Phong著色

### 功能說明
## 1.Barycentric Coordinates
先利用點座標算出面積，再計算alpha、beta跟gamma，然後因為要求Perspective-Correct Interpolation，所以再各除以三個點的W

![](./ComputerGraphics_Yeh-Lab4/HW4/ima1.jpg)
## 2.Phong Shading
先以三角形頂點內插任意點的向量，再用任一點的向量計算光照後的顏色
![](./ComputerGraphics_Yeh-Lab4/HW4/ima2.jpg)
![](./ComputerGraphics_Yeh-Lab4/HW4/ima3.jpg)
![](./ComputerGraphics_Yeh-Lab4/HW4/ima4.jpg)
## 3.Flat Shading
算出三角形的向量作為任意點的向量，計算光照的顏色
![](./ComputerGraphics_Yeh-Lab4/HW4/flat1.jpg)
![](./ComputerGraphics_Yeh-Lab4/HW4/flat2.jpg)
![](./ComputerGraphics_Yeh-Lab4/HW4/flat3.jpg)
## 4.Gouraud Shading
算出三角形頂點的光照顏色，再去內插任意點的光照顏色
![](./ComputerGraphics_Yeh-Lab4/HW4/g1.jpg)
![](./ComputerGraphics_Yeh-Lab4/HW4/g2.jpg)
![](./ComputerGraphics_Yeh-Lab4/HW4/g3.jpg)

## 影片
![](./ComputerGraphics_Yeh-Lab4/HW4/ggg.gif)


