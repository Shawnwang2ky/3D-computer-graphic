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
    int intersections = 0;
    for (int i = 0; i < vertexes.length; i++) {
        Vector3 v1 = vertexes[i];
        Vector3 v2 = vertexes[(i + 1) % vertexes.length];

        if (((v1.y > y) != (v2.y > y)) && 
            (x < (v2.x - v1.x) * (y - v1.y) / (v2.y - v1.y) + v1.x)) {
            intersections++;
        }
    }
    return (intersections % 2) != 0;
}

public Vector3[] findBoundBox(Vector3[] v) {    
    Vector3 recordminV = new Vector3(Float.MAX_VALUE, Float.MAX_VALUE, Float.MAX_VALUE);
    Vector3 recordmaxV = new Vector3(Float.MIN_VALUE, Float.MIN_VALUE, Float.MIN_VALUE);

    for (Vector3 vertex : v) {
        recordminV.x = Math.min(recordminV.x, vertex.x);
        recordminV.y = Math.min(recordminV.y, vertex.y);
        recordminV.z = Math.min(recordminV.z, vertex.z);

        recordmaxV.x = Math.max(recordmaxV.x, vertex.x);
        recordmaxV.y = Math.max(recordmaxV.y, vertex.y);
        recordmaxV.z = Math.max(recordmaxV.z, vertex.z);
    }

    return new Vector3[]{recordminV, recordmaxV};
}


public float getDepth(float x, float y, Vector3[] vertex) {
    // TODO HW3
    // You need to calculate the depth (z) in the triangle (vertex) based on the
    // positions x and y. and return the z value;

    Vector3 A = vertex[0];
    Vector3 B = vertex[1];
    Vector3 C = vertex[2];

    // 計算 (x, y) 的重心坐標
    float denominator = (B.y - C.y) * (A.x - C.x) + (C.x - B.x) * (A.y - C.y);
    float wA = ((B.y - C.y) * (x - C.x) + (C.x - B.x) * (y - C.y)) / denominator;
    float wB = ((C.y - A.y) * (x - C.x) + (A.x - C.x) * (y - C.y)) / denominator;
    float wC = 1.0f - wA - wB;

    // 使用重心坐標內插 z 值
    return wA * A.z + wB * B.z + wC * C.z;
}


float[] barycentric(Vector3 P, Vector4[] verts) {

    Vector3 A = verts[0].homogenized();
    Vector3 B = verts[1].homogenized();
    Vector3 C = verts[2].homogenized();

    // TODO HW4
    // Calculate the barycentric coordinates of point P in the triangle verts using
    // the barycentric coordinate system.

    float[] result = { 0.0, 0.0, 0.0 };

    return result;
}
