surface basicLight
(
    float Ka = 1,
          Kd = 1,
          Ks = 1,
          roughness = 0.15;
    color specularColor = color(1);
)
{
    normal Nn = faceforward(normalize(N), I);
    vector V = -normalize(I);

    Oi = Os;
    Ci = Oi * (Cs * (Ka * ambient() + Kd * diffuse(Nn))) +
               specularColor * Ks * specular(Nn, V, roughness);
}