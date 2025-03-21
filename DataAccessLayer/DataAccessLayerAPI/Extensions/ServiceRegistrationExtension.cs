using Bogus;
using DataAccessLayerAPI.Models;

namespace DataAccessLayerAPI.Extensions;

public static class ServiceRegistrationExtension
{
    public static IServiceCollection AddServices(this IServiceCollection services)
    {
        services.AddSingleton<IDictionary<Guid, User>>(services =>
        {
            return (
                new Faker<User>()
                    .RuleFor(u => u.Id, f => f.Random.Guid())
                    .RuleFor(u => u.Name, f => f.Name.FullName())
                    .RuleFor(u => u.Email, f => f.Internet.Email().ToLower())
            )
                .Generate(50)
                .ToDictionary(u => u.Id);
        });
        services.AddEndpointsApiExplorer();
        services.AddSwaggerGen();
        return services;
    }
}
