public void CGLine(float x1, float y1, float x2, float y2) {
    float dx = x2 - x1;
    float dy = y2 - y1;
    int step = (int) max(abs(dx),abs(dy));
    
    float xdiff = dx / step;
    float ydiff = dy / step;
    
    float x = x1;
    float y = y1;
    for (int i = 0;i < step; ++i){
      drawPoint(x,y,color(0,0,0));
      x += xdiff;
      y += ydiff;
    }
    
}


public void CGCircle(float xc, float yc, float r) {
    // 圓的參數方程法
    float step = 1.0f / r; // 根據半徑選擇步進量，半徑越大步進越小
    for (float theta = 0; theta < TWO_PI; theta += step) {
        // 使用參數方程計算圓周上的點
        float x = xc + r * cos(theta);
        float y = yc + r * sin(theta);
        
        // 畫出圓上的點
        drawPoint(x, y, color(0, 0, 0));
    }
}



public void CGEllipse(float xc, float yc, float r1, float r2) {
    // 設置步進角度，根據半徑選擇合理的步進值
    float step = 1.0f / max(r1, r2);  // 根據較大的半徑決定步進
    for (float theta = 0; theta < TWO_PI; theta += step) {
        // 使用橢圓的參數方程計算橢圓上的點
        float x = xc + r1 * cos(theta);
        float y = yc + r2 * sin(theta);
        
        // 繪製橢圓上的點
        drawPoint(x, y, color(0, 0, 0));
    }
}


public void CGCurve(Vector3 p1, Vector3 p2, Vector3 p3, Vector3 p4) {
    // 設置步進值，這會決定曲線的精細程度
    float step = 0.001f; // 每次 t 增加 0.01，繪製 100 個點來近似曲線

    // 循環遍歷 t 的值從 0 到 1，並計算對應的曲線點
    for (float t = 0; t <= 1; t += step) {
        // 使用貝茲曲線公式計算 P(t) 的座標
        float x = pow(1 - t, 3) * p1.x +
                  3 * pow(1 - t, 2) * t * p2.x +
                  3 * (1 - t) * pow(t, 2) * p3.x +
                  pow(t, 3) * p4.x;

        float y = pow(1 - t, 3) * p1.y +
                  3 * pow(1 - t, 2) * t * p2.y +
                  3 * (1 - t) * pow(t, 2) * p3.y +
                  pow(t, 3) * p4.y;

        // 繪製曲線上的點
        drawPoint(x, y, color(0, 0, 0));
    }
}

public void CGEraser(Vector3 p1, Vector3 p2) {
    // 設定背景顏色
    int backgroundColor = color(250);

    // 確定矩形的邊界
    int xMin = (int) min(p1.x, p2.x);
    int xMax = (int) max(p1.x, p2.x);
    int yMin = (int) min(p1.y, p2.y);
    int yMax = (int) max(p1.y, p2.y);

    // 在矩形區域內繪製背景顏色以擦除該區域
    for (int x = xMin; x <= xMax; x++) {
        for (int y = yMin; y <= yMax; y++) {
            drawPoint(x, y, backgroundColor); // 將該點設置為背景顏色，模擬橡皮擦
        }
    }
}


public void drawPoint(float x, float y, color c) {
    stroke(c);
    point(x, y);
}

public float distance(Vector3 a, Vector3 b) {
    Vector3 c = a.sub(b);
    return sqrt(Vector3.dot(c, c));
}
