using Api.Models;
using Microsoft.AspNetCore.Mvc;

namespace Api.Controllers;

public sealed class HealthController : Controller
{
    [HttpGet]
    public IActionResult Index()
    {
        var model = new HealthViewModel
        {
            Ok = true,
            Status = "healthy",
            Time = DateTimeOffset.UtcNow
        };

        return View(model);
    }
}
