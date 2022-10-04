using System.ComponentModel.DataAnnotations;

namespace UniversityApiBackend.DataModels
{
    public class Chapter : BaseEntity
    {
        public int CursoID { get; set; }
        public virtual Curso Curso { get; set; } = new Curso();

        [Required]
        public string List = string.Empty;
    }
}
