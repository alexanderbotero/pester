namespace DataAccessLayerAPI.DTOs;

public record UserRequestDTO
{
    public string Name { get; init; } = string.Empty;
    public string Email { get; init; } = string.Empty;
}
