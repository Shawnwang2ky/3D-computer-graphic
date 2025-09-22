public class Camera {
    Matrix4 projection = new Matrix4();
    Matrix4 worldView = new Matrix4();
    int wid;
    int hei;
    float near;
    float far;
    Transform transform;

    Camera() {
        wid = 256;
        hei = 256;
        worldView.makeIdentity();
        projection.makeIdentity();
        transform = new Transform();
    }

    Matrix4 inverseProjection() {
        Matrix4 invProjection = Matrix4.Zero();
        float a = projection.m[0];
        float b = projection.m[5];
        float c = projection.m[10];
        float d = projection.m[11];
        float e = projection.m[14];
        invProjection.m[0] = 1.0f / a;
        invProjection.m[5] = 1.0f / b;
        invProjection.m[11] = 1.0f / e;
        invProjection.m[14] = 1.0f / d;
        invProjection.m[15] = -c / (d * e);
        return invProjection;
    }

      Matrix4 Matrix() {
          // 返回 projection 和 worldView 的乘積，形成最終的變換矩陣
          return projection.mult(worldView);
      }
      
      void setSize(int w, int h, float n, float f) {
          wid = w;
          hei = h;
          near = n;
          far = f;
    
          
          projection = new Matrix4();
          float aspect = wid / hei;
          float tanHalfFOV = (float)Math.tan(Math.toRadians(GH_FOV / 2));
          projection.m[0] = 1;
         projection.m[5] = aspect;
          projection.m[10] = far / (far - near) * tanHalfFOV;
          projection.m[11] = far * near / (near - far) * tanHalfFOV;
          projection.m[14] = tanHalfFOV;
      }


    void setPositionOrientation(Vector3 pos, float rotX, float rotY) {

    }

    void setPositionOrientation(Vector3 pos, Vector3 lookat) {
        // 計算 Look-At 矩陣
        Vector3 forward = lookat.sub(pos).unit_vector();
        Vector3 up = new Vector3(0, 1, 0);
        Vector3 right = Vector3.cross(forward, up).unit_vector();
        up = Vector3.cross(right, forward).unit_vector();
    
        Matrix4 lookAt = new Matrix4();
        lookAt.m[0] = right.x; lookAt.m[1] = up.x; lookAt.m[2] = -forward.x; lookAt.m[3] = 0;
        lookAt.m[4] = right.y; lookAt.m[5] = up.y; lookAt.m[6] = -forward.y; lookAt.m[7] = 0;
        lookAt.m[8] = right.z; lookAt.m[9] = up.z; lookAt.m[10] = -forward.z; lookAt.m[11] = 0;
        lookAt.m[12] = -Vector3.dot(right, pos); lookAt.m[13] = -Vector3.dot(up, pos); lookAt.m[14] = -Vector3.dot(forward, pos); lookAt.m[15] = 1;
    
        worldView = lookAt;
    }
}
