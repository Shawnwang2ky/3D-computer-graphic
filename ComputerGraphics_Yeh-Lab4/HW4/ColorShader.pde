public class PhongVertexShader extends VertexShader {
    Vector4[][] main(Object[] attribute, Object[] uniform) {
        Vector3[] aVertexPosition = (Vector3[]) attribute[0];
        Vector3[] aVertexNormal = (Vector3[]) attribute[1];
        Matrix4 MVP = (Matrix4) uniform[0];
        Matrix4 M = (Matrix4) uniform[1];
        Vector4[] gl_Position = new Vector4[3];
        Vector4[] w_position = new Vector4[3];
        Vector4[] w_normal = new Vector4[3];

        for (int i = 0; i < gl_Position.length; i++) {
            gl_Position[i] = MVP.mult(aVertexPosition[i].getVector4(1.0));
            w_position[i] = M.mult(aVertexPosition[i].getVector4(1.0));
            w_normal[i] = M.mult(aVertexNormal[i].getVector4(0.0));
        }

        Vector4[][] result = { gl_Position, w_position, w_normal };

        return result;
    }
}

public class PhongFragmentShader extends FragmentShader{
    Vector4 main(Object[] varying){
        Vector3 position = (Vector3)varying[0];
        Vector3 w_position = (Vector3)varying[1];
        Vector3 w_normal = (Vector3)varying[2];
        Vector3 albedo = (Vector3) varying[3];
        Vector3 kdksm = (Vector3) varying[4];
        Light light = basic_light;
        Camera cam = main_camera;

        Vector3 lightDir = (light.transform.position.sub(w_position)).unit_vector();

        Vector3 viewDir = (cam.transform.position.sub(w_position)).unit_vector();

        Vector3 normal = w_normal.unit_vector();

        Vector3 ambient = AMBIENT_LIGHT.product(basic_light.light_color);
        Vector3 diffuse = basic_light.light_color.mult(kdksm.x).mult(Math.max(Vector3.dot(normal, lightDir), 0.0));
        
        Vector3 reflectDir = (normal.mult(2.0 * Vector3.dot(lightDir, normal))).sub(lightDir);
        float specFactor = (float) Math.pow(Math.max(Vector3.dot(viewDir, reflectDir), 0.0), kdksm.z);
        Vector3 specular = basic_light.light_color.mult(kdksm.y * specFactor);

        Vector3 finalColor = new Vector3(
            ambient.x * albedo.x + diffuse.x * albedo.x + specular.x * albedo.x,
            ambient.y * albedo.y + diffuse.y * albedo.y + specular.y * albedo.y,
            ambient.z * albedo.z + diffuse.z * albedo.z + specular.z * albedo.z
        );

        return new Vector4(finalColor.x, finalColor.y, finalColor.z, 1.0);
    }
}

public class FlatVertexShader extends VertexShader{
    Vector4[][] main(Object[] attribute, Object[] uniform) {
        Vector3[] aVertexPosition = (Vector3[])attribute[0];
        Vector3[] aVertexNormal = (Vector3[])attribute[1];
        Matrix4 MVP = (Matrix4)uniform[0];
        Matrix4 M = (Matrix4)uniform[1];
        Vector4[] gl_Position = new Vector4[3];
        Vector4[] w_position = new Vector4[3];
        Vector4[] w_normal = new Vector4[3];
        
        Vector3 T1 = aVertexPosition[0].sub(aVertexPosition[1]);
        Vector3 T2 = aVertexPosition[0].sub(aVertexPosition[2]);
        Vector3 N = Vector3.cross(T1,T2);

        for (int i = 0; i < gl_Position.length; i++) {
            gl_Position[i] = MVP.mult(aVertexPosition[i].getVector4(1.0));
            w_position[i] = M.mult(aVertexPosition[i].getVector4(1.0));
            w_normal[i] = M.mult(N.getVector4(0.0));
        }

        Vector4[][] result = {gl_Position, w_position, w_normal};
        return result;
    }
}

public class FlatFragmentShader extends FragmentShader{
    Vector4 main(Object[] varying){
        Vector3 position = (Vector3)varying[0];
        Vector3 w_position = (Vector3)varying[1];
        Vector3 w_normal = (Vector3)varying[2];
        Vector3 albedo = (Vector3) varying[3];
        Vector3 kdksm = (Vector3) varying[4];
        Light light = basic_light;
        Camera cam = main_camera;

        Vector3 lightDir = (light.transform.position.sub(w_position)).unit_vector();
        Vector3 viewDir = (cam.transform.position.sub(w_position)).unit_vector();
        Vector3 normal = w_normal.unit_vector();

        Vector3 ambient = AMBIENT_LIGHT.product(basic_light.light_color);
        Vector3 diffuse = basic_light.light_color.mult(kdksm.x).mult(Math.max(Vector3.dot(normal, lightDir), 0.0));

        Vector3 reflectDir = (normal.mult(2.0 * Vector3.dot(lightDir, normal))).sub(lightDir);
        float specFactor = (float) Math.pow(Math.max(Vector3.dot(viewDir, reflectDir), 0.0), kdksm.z);
        Vector3 specular = basic_light.light_color.mult(kdksm.y * specFactor);

        Vector3 finalColor = new Vector3(
            ambient.x * albedo.x + diffuse.x * albedo.x + specular.x * albedo.x,
            ambient.y * albedo.y + diffuse.y * albedo.y + specular.y * albedo.y,
            ambient.z * albedo.z + diffuse.z * albedo.z + specular.z * albedo.z
        );

        return new Vector4(finalColor.x, finalColor.y, finalColor.z, 1.0);
    }
}

public class GouraudVertexShader extends VertexShader{
    Vector4[][] main(Object[] attribute,Object[] uniform){
        Vector3[] aVertexPosition = (Vector3[])attribute[0];
        Vector3[] aVertexNormal = (Vector3[])attribute[1];
        Vector3 albedo = (Vector3) attribute[2];
        Vector3 kdksm = (Vector3) attribute[3];
        Light light = basic_light;
        Camera cam = main_camera;
        Matrix4 MVP = (Matrix4)uniform[0];
        Matrix4 M = (Matrix4)uniform[1];
        Vector4[] gl_Position = new Vector4[3];
        Vector4[] w_position = new Vector4[3];
        Vector4[] w_normal = new Vector4[3];
        Vector4[] pointColor = new Vector4[3];
        
        
        for(int i=0;i<gl_Position.length;i++){
            gl_Position[i] = MVP.mult(aVertexPosition[i].getVector4(1.0));
            w_position[i] = M.mult(aVertexPosition[i].getVector4(1.0));
            w_normal[i] = M.mult(aVertexNormal[i].getVector4(0.0));
        }

        Vector3 ambient = AMBIENT_LIGHT.product(basic_light.light_color);

        for(int i=0;i<gl_Position.length;i++){
          
            Vector3 lightDir = (light.transform.position.sub(w_position[i].xyz())).unit_vector();
            Vector3 viewDir = (cam.transform.position.sub(w_position[i].xyz())).unit_vector();
            Vector3 normal = w_normal[i].xyz().unit_vector(); 
            Vector3 diffuse = basic_light.light_color.mult(kdksm.x).mult(Math.max(Vector3.dot(normal, lightDir), 0.0));

            Vector3 reflectDir = (normal.mult(2.0 * Vector3.dot(lightDir, normal))).sub(lightDir);
            float specFactor = (float) Math.pow(Math.max(Vector3.dot(viewDir, reflectDir), 0.0), kdksm.z);
            Vector3 specular = basic_light.light_color.mult(kdksm.y).mult(specFactor);
    
            Vector3 finalColor = new Vector3(
                ambient.x * albedo.x + diffuse.x * albedo.x + specular.x * albedo.x,
                ambient.y * albedo.y + diffuse.y * albedo.y + specular.y * albedo.y,
                ambient.z * albedo.z + diffuse.z * albedo.z + specular.z * albedo.z
            );

            pointColor[i] = finalColor.getVector4(1.0);
        }
        return new Vector4[][]{gl_Position,pointColor};
    }
}

public class GouraudFragmentShader extends FragmentShader{
    Vector4 main(Object[] varying){
        Vector3 position = (Vector3)varying[0];
        Vector3 pointColor = (Vector3)varying[1];
        int norm = -50;

        return new Vector4(pointColor.mult(norm),1.0);
    }
}
