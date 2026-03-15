namespace Api.Models;

public sealed class HomeViewModel
{
    public string Name { get; init; } = string.Empty;
    public string Status { get; init; } = string.Empty;
    public DateTimeOffset Time { get; init; }
}
