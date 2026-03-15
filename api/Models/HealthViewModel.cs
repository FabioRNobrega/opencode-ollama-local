namespace Api.Models;

public sealed class HealthViewModel
{
    public bool Ok { get; init; }
    public string Status { get; init; } = string.Empty;
    public DateTimeOffset Time { get; init; }
}
