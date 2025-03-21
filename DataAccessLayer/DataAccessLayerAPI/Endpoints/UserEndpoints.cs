using DataAccessLayerAPI.DTOs;
using DataAccessLayerAPI.Models;

namespace DataAccessLayerAPI.Endpoints;

public static class UserEndpoints
{
    public static void AddUserEndpoints(this WebApplication app)
    {
        const string apiPath = "/users";
        const string apiPathWithId = apiPath + "/{id}";
        const string apiTag = "Users";

        app.MapGet(
                apiPath,
                (IDictionary<Guid, User> users) =>
                {
                    return Results.Ok(users.Values);
                }
            )
            .WithTags(apiTag)
            .Produces<ICollection<User>>(StatusCodes.Status200OK);

        app.MapGet(
                apiPathWithId,
                (Guid id, IDictionary<Guid, User> users) =>
                {
                    if (users.TryGetValue(id, out var user))
                    {
                        return Results.Ok(user);
                    }
                    return Results.NotFound();
                }
            )
            .WithName("GetUser")
            .WithTags(apiTag)
            .Produces<User>(StatusCodes.Status200OK)
            .Produces(StatusCodes.Status404NotFound);

        app.MapPost(
                apiPath,
                (UserRequestDTO newUser, IDictionary<Guid, User> users) =>
                {
                    var user = new User
                    {
                        Id = Guid.NewGuid(),
                        Name = newUser.Name,
                        Email = newUser.Email,
                    };
                    users.Add(user.Id, user);
                    return Results.CreatedAtRoute("GetUser", new { id = user.Id }, user);
                }
            )
            .WithTags(apiTag)
            .Produces<User>(StatusCodes.Status201Created);

        app.MapPut(
                apiPathWithId,
                (Guid id, UserRequestDTO updatedUser, IDictionary<Guid, User> users) =>
                {
                    if (!users.ContainsKey(id))
                    {
                        return Results.NotFound();
                    }

                    var user = new User
                    {
                        Id = id,
                        Name = updatedUser.Name,
                        Email = updatedUser.Email,
                    };

                    users[id] = user;
                    return TypedResults.Ok(user);
                }
            )
            .WithTags(apiTag)
            .Produces<User>(StatusCodes.Status200OK)
            .Produces(StatusCodes.Status404NotFound);

        app.MapDelete(
                apiPathWithId,
                (Guid id, IDictionary<Guid, User> users) =>
                {
                    if (!users.ContainsKey(id))
                    {
                        return Results.NotFound();
                    }

                    users.Remove(id);
                    return TypedResults.NoContent();
                }
            )
            .WithTags(apiTag)
            .Produces(StatusCodes.Status204NoContent)
            .Produces(StatusCodes.Status404NotFound);
    }
}
