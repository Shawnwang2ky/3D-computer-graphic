# computer-graphic_NCU

## 描述
完成三角形的Barycentric Coordinates、Flat Shading、Gouraud著色、Phong著色

### 功能說明
## 1.Barycentric Coordinates
先利用點座標算出面積，再計算alpha、beta跟gamma，然後因為要求Perspective-Correct Interpolation，所以再各除以三個點的W

![](./HW4/ima1.jpg)
## 2.Phong Shading
先以三角形頂點內插任意點的向量，再用任一點的向量計算光照後的顏色
![](./HW4/ima2.jpg)
![](./HW4/ima3.jpg)
![](./HW4/ima4.jpg)
## 3.Flat Shading
算出三角形的向量作為任意點的向量，計算光照的顏色
![](./HW4/flat1.jpg)
![](./HW4/flat2.jpg)
![](./HW4/flat3.jpg)
## 4.Gouraud Shading
算出三角形頂點的光照顏色，再去內插任意點的光照顏色
![](./HW4/g1.jpg)
![](./HW4/g2.jpg)
![](./HW4/g3.jpg)

## 影片
![](./HW4/ggg.gif)
