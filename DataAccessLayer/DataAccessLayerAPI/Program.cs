using DataAccessLayerAPI.Endpoints;
using DataAccessLayerAPI.Extensions;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddServices();

var app = builder.Build();

app.AddUserEndpoints();

app.UseSwagger();
app.UseSwaggerUI();

app.Run();
