﻿using Microsoft.EntityFrameworkCore;
using UniversityApiBackend.DataModels;

namespace UniversityApiBackend.DataAccess
{
    public class UniversityDBContext: DbContext
    {
        public UniversityDBContext(DbContextOptions<UniversityDBContext> options): base(options)
        {
        
        }

        // TO DO: Add DbSets (Tables of our Data Base)
        public DbSet<User>? Users { get; set; }
    }
}
