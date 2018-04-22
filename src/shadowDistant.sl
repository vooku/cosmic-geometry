light shadowDistant
(
    float intensity = 1,
          blur = 0.03;
    color lightcolor = 1;
    point from = point "shader" (0,0,0),
          to = point "shader" (0,0,1);
    string shadowfile = ""
)
{
    solar(to-from, 0.0) {
        Cl = intensity * lightcolor;
        if (shadowfile != "")
            Cl *= (1.0 - shadow(shadowfile, Ps, "blur", blur));
    }
}
