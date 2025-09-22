public void CGLine(float x1, float y1, float x2, float y2) {
    stroke(0);
    line(x1, y1, x2, y2);
}

public boolean outOfBoundary(float x, float y) {
    if (x < 0 || x >= width || y < 0 || y >= height)
        return true;
    return false;
}

public void drawPoint(float x, float y, color c) {
    int index = (int) y * width + (int) x;
    if (outOfBoundary(x, y))
        return;
    pixels[index] = c;
}

public float distance(Vector3 a, Vector3 b) {
    Vector3 c = a.sub(b);
    return sqrt(Vector3.dot(c, c));
}

boolean pnpoly(float x, float y, Vector3[] vertexes) {
    // TODO HW2
    // You need to check the coordinate p(x,v) if inside the vertexes. 
    int n = vertexes.length;
    boolean inside = false;

    // 射線法檢查交點
    for (int i = 0, j = n - 1; i < n; j = i++) {
        float xi = vertexes[i].x;
        float yi = vertexes[i].y;
        float xj = vertexes[j].x;
        float yj = vertexes[j].y;

        // 檢查邊是否與射線相交
        boolean intersect = ((yi > y) != (yj > y)) && 
                            (x < (xj - xi) * (y - yi) / (yj - yi) + xi);
        if (intersect) {
            inside = !inside; // 每次交點反轉內外狀態
        }
    }

    return inside;
}

public Vector3[] findBoundBox(Vector3[] v) {
    //Vector3 recordminV = new Vector3(1.0 / 0.0);
    //Vector3 recordmaxV = new Vector3(-1.0 / 0.0);
    // TODO HW2
    // You need to find the bounding box of the vertexes v.

    //Vector3[] result = { recordminV, recordmaxV };
    //return result;
    if (v == null || v.length == 0) {
        return new Vector3[] { new Vector3(0), new Vector3(0) };
    }

    // 初始化最小和最大
    Vector3 minV = new Vector3(Float.MAX_VALUE); // 初始設置為正無窮大
    Vector3 maxV = new Vector3(Float.MIN_VALUE); // 初始設置為負無窮大

    // 走遍所有頂點
    for (Vector3 vertex : v) {
        if (vertex.x < minV.x) minV.x = vertex.x;
        if (vertex.y < minV.y) minV.y = vertex.y;
        if (vertex.z < minV.z) minV.z = vertex.z;

        if (vertex.x > maxV.x) maxV.x = vertex.x;
        if (vertex.y > maxV.y) maxV.y = vertex.y;
        if (vertex.z > maxV.z) maxV.z = vertex.z;
    }

    // 返回包含最小和最大向量的陣列
    return new Vector3[] { minV, maxV };
}

public Vector3[] Sutherland_Hodgman_algorithm(Vector3[] points, Vector3[] boundary) {
    ArrayList<Vector3> input = new ArrayList<Vector3>();
    ArrayList<Vector3> output = new ArrayList<Vector3>();
    for (int i = 0; i < points.length; i += 1) {
        input.add(points[i]);
    }

    // TODO HW2
    // You need to implement the Sutherland Hodgman Algorithm in this section.
    // The function you pass 2 parameter. One is the vertexes of the shape "points".
    // And the other is the vertexes of the "boundary".
    // The output is the vertexes of the polygon.

    output = input;

    Vector3[] result = new Vector3[output.size()];
    for (int i = 0; i < result.length; i += 1) {
        result[i] = output.get(i);
    }
    return result;
}

public float getDepth(float x, float y, Vector3[] vertex) {
    // TODO HW3
    // You need to calculate the depth (z) in the triangle (vertex) based on the
    // positions x and y. and return the z value;
    Vector3 v0 = vertex[0]; // First vertex (x0, y0, z0)
    Vector3 v1 = vertex[1]; // Second vertex (x1, y1, z1)
    Vector3 v2 = vertex[2]; // Third vertex (x2, y2, z2)

    // Calculate the area of the whole triangle using cross product
    float denom = (v1.y() - v2.y()) * (v0.x() - v2.x()) + 
                  (v2.x() - v1.x()) * (v0.y() - v2.y());

    // Barycentric weights
    float w0 = ((v1.y() - v2.y()) * (x - v2.x()) + 
                (v2.x() - v1.x()) * (y - v2.y())) / denom;

    float w1 = ((v2.y() - v0.y()) * (x - v2.x()) + 
                (v0.x() - v2.x()) * (y - v2.y())) / denom;

    float w2 = 1.0f - w0 - w1;

    // Interpolate depth using barycentric weights
    //System.out.println(w0 * v0.z() + w1 * v1.z() + w2 * v2.z());
    return w0 * v0.z() + w1 * v1.z() + w2 * v2.z();
}

float[] barycentric(Vector3 P, Vector4[] verts) {

    Vector3 A = verts[0].homogenized();
    Vector3 B = verts[1].homogenized();
    Vector3 C = verts[2].homogenized();

    Vector4 AW = verts[0];
    Vector4 BW = verts[1];
    Vector4 CW = verts[2];

    // TODO HW4
    // Calculate the barycentric coordinates of point P in the triangle verts using
    // the barycentric coordinate system.
    // Please notice that you should use Perspective-Correct Interpolation otherwise
    // you will get wrong answer.

    //float[] result = { 0.0, 0.0, 0.0 };

    //return result;
    // 計算基於透視校正的重心座標
    float area = (A.x * (B.y - C.y) + B.x * (C.y - A.y) + C.x * (A.y - B.y));
    
    // 計算 alpha, beta, gamma
    float alpha = ((P.x * (B.y - C.y) + B.x * (C.y - P.y) + C.x * (P.y - B.y)) / area);
    float beta  = ((P.x * (C.y - A.y) + C.x * (A.y - P.y) + A.x * (P.y - C.y)) / area);
    float gamma = 1.0f - alpha - beta;

    // 透視校正
    alpha /= AW.w;
    beta  /= BW.w;
    gamma /= CW.w;

    // 進行透視校正後的內插
    float[] result = { alpha, beta, gamma };
    return result;
}

Vector3 interpolation(float[] abg, Vector3[] v) {
    return v[0].mult(abg[0]).add(v[1].mult(abg[1])).add(v[2].mult(abg[2]));
}

Vector4 interpolation(float[] abg, Vector4[] v) {
    return v[0].mult(abg[0]).add(v[1].mult(abg[1])).add(v[2].mult(abg[2]));
}

float interpolation(float[] abg, float[] v) {
    return v[0] * abg[0] + v[1] * abg[1] + v[2] * abg[2];
}
