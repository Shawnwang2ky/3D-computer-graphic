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
    // You need to check the coordinate p(x,v) if inside the vertices. 
    // If yes return true, vice versa.
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


public Vector3[] Sutherland_Hodgman_algorithm(Vector3[] points, Vector3[] boundary) {
    ArrayList<Vector3> input = new ArrayList<>();
    ArrayList<Vector3> output;
    for (int i = 0; i < points.length; i += 1) {
        input.add(points[i]);
    }

    // Iterate over each edge of the clipping boundary
    for (int j = 0; j < boundary.length; j++) {
        output = new ArrayList<>();
        Vector3 boundaryStart = boundary[j];
        Vector3 boundaryEnd = boundary[(j + 1) % boundary.length];

        for (int i = 0; i < input.size(); i++) {
            Vector3 currentPoint = input.get(i);
            Vector3 previousPoint = input.get((i + input.size() - 1) % input.size());

            boolean currentInside = isInside(currentPoint, boundaryStart, boundaryEnd);
            boolean previousInside = isInside(previousPoint, boundaryStart, boundaryEnd);

            if (currentInside) {
                if (!previousInside) {
                    output.add(intersect(previousPoint, currentPoint, boundaryStart, boundaryEnd));
                }
                output.add(currentPoint);
            } else if (previousInside) {
                output.add(intersect(previousPoint, currentPoint, boundaryStart, boundaryEnd));
            }
        }

        input = output; // Prepare for the next clipping boundary
    }

    return input.toArray(new Vector3[0]);
}

// Check if a point is inside the clipping boundary edge
private boolean isInside(Vector3 point, Vector3 edgeStart, Vector3 edgeEnd) {
    return (edgeEnd.x - edgeStart.x) * (point.y - edgeStart.y) - (edgeEnd.y - edgeStart.y) * (point.x - edgeStart.x) <= 0;
}

// Find the intersection point between the polygon edge and the clipping boundary edge
private Vector3 intersect(Vector3 start, Vector3 end, Vector3 boundaryStart, Vector3 boundaryEnd) {
    float dx1 = end.x - start.x;
    float dy1 = end.y - start.y;
    float dx2 = boundaryEnd.x - boundaryStart.x;
    float dy2 = boundaryEnd.y - boundaryStart.y;

    float denominator = dx1 * dy2 - dy1 * dx2;
    float ua = ((boundaryStart.x - start.x) * dy2 - (boundaryStart.y - start.y) * dx2) / denominator;

    return new Vector3(start.x + ua * dx1, start.y + ua * dy1, start.z); // Assuming 2D clipping
}
