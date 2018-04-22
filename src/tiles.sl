displacement tiles
(
    string tiletex = "";
    float depth = 0.08,
          __displacementbound_sphere = depth;
    string __displacementbound_coordinatesystem = "current"
)
{
    if (tiletex != "") {
        P -= normalize(N) * depth * texture(tiletex, s, t);
        N = calculatenormal(P);
    }   
}