namespace DataAccessLayerAPI.Models;

public class User
{
    public Guid Id { get; init; } = new Guid();
    public string Name { get; init; } = string.Empty;
    public string Email { get; init; } = string.Empty;
}
