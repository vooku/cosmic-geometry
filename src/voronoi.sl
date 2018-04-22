void voronoi_f1f2_3d
(
    point P;
    output float f1,
                 f2;
    output point pos1,
                 pos2
)
{
    f1 = f2 = 1000;
    point thiscell = point (floor(xcomp(P)) + 0.5, floor(ycomp(P)) + 0.5, floor(zcomp(P)) + 0.5);
    uniform float i, j, k;

    for (i = -1; i <= 1; i += 1) {
        for (j = -1; j <= 1; j += 1) {
            for (k = -1; k <= 1; k += 1) {
                point testcell = thiscell + vector(i,j,k);
                point pos = point(testcell + vector cellnoise(testcell) - 0.5);
                vector offset = pos - P;
                float dist = distance(pos, P);

              if (dist < f1) {
                f2 = f1;
                pos2 = pos1;
                f1 = dist;
                pos1 = pos;
              }
              else if (dist < f2) {
                f2 = dist;
                pos2 = pos;
              }
            }
        }
    }
}

surface voronoi
(
    float Ka = 1,
          Kd = 1,
          frequency = 10;
    color tileColor = color(0),
          gapColor = color(1),
          specularColor = color(1);
)
{
    normal Nn = faceforward(normalize(N), I);

    float f1, f2;
    point pos1, pos2;
    voronoi_f1f2_3d(P, f1, f2, pos1, pos2);

    f1 += noise(u * frequency, v * frequency) * 0.2 - 0.025;
    Ci = step(0.05, f2-f1);
    Ci = mix(gapColor, tileColor, Ci);

    Oi = Os;
    Ci *= Ka * ambient() + Kd * diffuse(Nn);
    Ci *= Oi;
}