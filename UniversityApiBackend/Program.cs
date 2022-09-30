// 1. Usings to work with EntityFramework
using Microsoft.EntityFrameworkCore;
using UniversityApiBackend.DataAccess;

var builder = WebApplication.CreateBuilder(args);


// 2. Conection with SQL Server Express
const string CONECTIONNAME = "UniversityDB";
var conectionstring = builder.Configuration.GetConnectionString(CONECTIONNAME);

// 3. Add Context to Service Builder. 
builder.Services.AddDbContext<UniversityDBContext>(options => options.UseSqlServer(conectionstring));

// Add services to the container.

builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();

app.Run();
