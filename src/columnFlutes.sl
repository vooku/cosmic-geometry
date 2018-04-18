displacement columnFlutes 
(
    float depth = 0.1,
          frequency = 7,
          __displacementbound_sphere = depth;
    string __displacementbound_coordinatesystem = "current"
)
{
    float magnitude = depth * -abs(sin(2*PI*s*frequency));

    P += normalize(N) * magnitude;
    N = calculatenormal(P);
}