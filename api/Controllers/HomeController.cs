using Api.Models;
using Microsoft.AspNetCore.Mvc;

namespace Api.Controllers;

public sealed class HomeController : Controller
{
    [HttpGet]
    public IActionResult Index()
    {
        var model = new HomeViewModel
        {
            Name = "OpenCode Docker Demo API",
            Status = "running",
            Time = DateTimeOffset.UtcNow
        };

        return View(model);
    }
}
