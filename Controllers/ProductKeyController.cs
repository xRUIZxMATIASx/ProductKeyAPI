using Microsoft.AspNetCore.Mvc;
using System;
using KeySecurity; // Aquí importamos la librería KeySecurity

namespace ProductKeyAPI.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class ProductKeyController : ControllerBase
    {
        [HttpGet("generate")]
        public IActionResult GenerateKey(
            [FromQuery] string activationCode, 
            [FromQuery] int validDays, 
            [FromQuery] string info)
        {
            try
            {
                string generatedKey = KeySecurity.KeySecurity.GenerateKeyActivate(activationCode, validDays, info);
                return Ok(new { generatedKey });
            }
            catch (Exception ex)
            {
                return BadRequest(new { error = ex.Message });
            }
        }
    }
}
