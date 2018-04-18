surface helloWorld
(
    uniform float Ka = 1;
    uniform float Kd = 1;
    uniform float Ks = 1;
    uniform float roughness = 0.15;
    uniform color specularColor = color(1);
)
{
    normal Nn = normalize(N);

    // dirty hotfix because not all normals are correct in my hand written models
    if (normalize(I) . Nn > 0)
        Nn = normalize(-N);

    vector V = -normalize(I);

    Oi = Os;
    Ci = Oi * (Cs * (Ka * ambient() + Kd * diffuse(Nn))) +
               specularColor * Ks * specular(Nn, V, roughness);
}