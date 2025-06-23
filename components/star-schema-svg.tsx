export default function StarSchemaSVG() {
  return (
    <svg viewBox="0 0 1200 800" className="w-full h-auto border rounded-lg bg-white">
      {/* Background */}
      <rect width="1200" height="800" fill="#f8fafc" />

      {/* Title */}
      <text x="600" y="30" textAnchor="middle" className="text-xl font-bold fill-gray-800">
        University Data Warehouse - Star Schema
      </text>

      {/* Central Fact Table */}
      <g>
        <rect x="450" y="300" width="300" height="200" fill="#fef3c7" stroke="#f59e0b" strokeWidth="3" rx="10" />
        <text x="600" y="325" textAnchor="middle" className="text-lg font-bold fill-amber-800">
          FACT_ENROLLMENTS
        </text>

        {/* Measures */}
        <text x="460" y="350" className="text-sm font-semibold fill-amber-700">
          Measures:
        </text>
        <text x="460" y="365" className="text-xs fill-amber-700">
          • enrollment_count
        </text>
        <text x="460" y="378" className="text-xs fill-amber-700">
          • final_grade
        </text>
        <text x="460" y="391" className="text-xs fill-amber-700">
          • credits_attempted
        </text>
        <text x="460" y="404" className="text-xs fill-amber-700">
          • credits_earned
        </text>
        <text x="460" y="417" className="text-xs fill-amber-700">
          • gpa_points
        </text>

        {/* Foreign Keys */}
        <text x="600" y="350" className="text-sm font-semibold fill-amber-700">
          Foreign Keys:
        </text>
        <text x="600" y="365" className="text-xs fill-amber-700">
          • student_key
        </text>
        <text x="600" y="378" className="text-xs fill-amber-700">
          • course_key
        </text>
        <text x="600" y="391" className="text-xs fill-amber-700">
          • faculty_key
        </text>
        <text x="600" y="404" className="text-xs fill-amber-700">
          • department_key
        </text>
        <text x="600" y="417" className="text-xs fill-amber-700">
          • semester_key
        </text>
        <text x="600" y="430" className="text-xs fill-amber-700">
          • section_key
        </text>

        {/* Flags */}
        <text x="460" y="450" className="text-sm font-semibold fill-amber-700">
          Flags:
        </text>
        <text x="460" y="465" className="text-xs fill-amber-700">
          • is_passing
        </text>
        <text x="460" y="478" className="text-xs fill-amber-700">
          • is_honors
        </text>
      </g>

      {/* Dimension Tables */}

      {/* dim_students */}
      <g>
        <rect x="50" y="50" width="200" height="120" fill="#dbeafe" stroke="#3b82f6" strokeWidth="2" rx="5" />
        <text x="150" y="75" textAnchor="middle" className="font-bold fill-blue-800">
          DIM_STUDENTS
        </text>
        <text x="60" y="95" className="text-xs fill-blue-700">
          • student_key (PK)
        </text>
        <text x="60" y="108" className="text-xs fill-blue-700">
          • student_id
        </text>
        <text x="60" y="121" className="text-xs fill-blue-700">
          • full_name
        </text>
        <text x="60" y="134" className="text-xs fill-blue-700">
          • age_group
        </text>
        <text x="60" y="147" className="text-xs fill-blue-700">
          • class_level
        </text>
        <text x="60" y="160" className="text-xs fill-blue-700">
          • gpa
        </text>
      </g>

      {/* dim_courses */}
      <g>
        <rect x="950" y="50" width="200" height="120" fill="#dcfce7" stroke="#22c55e" strokeWidth="2" rx="5" />
        <text x="1050" y="75" textAnchor="middle" className="font-bold fill-green-800">
          DIM_COURSES
        </text>
        <text x="960" y="95" className="text-xs fill-green-700">
          • course_key (PK)
        </text>
        <text x="960" y="108" className="text-xs fill-green-700">
          • course_id
        </text>
        <text x="960" y="121" className="text-xs fill-green-700">
          • course_code
        </text>
        <text x="960" y="134" className="text-xs fill-green-700">
          • course_name
        </text>
        <text x="960" y="147" className="text-xs fill-green-700">
          • credits
        </text>
        <text x="960" y="160" className="text-xs fill-green-700">
          • subject_area
        </text>
      </g>

      {/* dim_faculty */}
      <g>
        <rect x="50" y="630" width="200" height="120" fill="#f3e8ff" stroke="#a855f7" strokeWidth="2" rx="5" />
        <text x="150" y="655" textAnchor="middle" className="font-bold fill-purple-800">
          DIM_FACULTY
        </text>
        <text x="60" y="675" className="text-xs fill-purple-700">
          • faculty_key (PK)
        </text>
        <text x="60" y="688" className="text-xs fill-purple-700">
          • faculty_id
        </text>
        <text x="60" y="701" className="text-xs fill-purple-700">
          • full_name
        </text>
        <text x="60" y="714" className="text-xs fill-purple-700">
          • position
        </text>
        <text x="60" y="727" className="text-xs fill-purple-700">
          • years_experience
        </text>
        <text x="60" y="740" className="text-xs fill-purple-700">
          • salary_range
        </text>
      </g>

      {/* dim_departments */}
      <g>
        <rect x="950" y="630" width="200" height="120" fill="#fef2f2" stroke="#ef4444" strokeWidth="2" rx="5" />
        <text x="1050" y="655" textAnchor="middle" className="font-bold fill-red-800">
          DIM_DEPARTMENTS
        </text>
        <text x="960" y="675" className="text-xs fill-red-700">
          • department_key (PK)
        </text>
        <text x="960" y="688" className="text-xs fill-red-700">
          • department_id
        </text>
        <text x="960" y="701" className="text-xs fill-red-700">
          • department_name
        </text>
        <text x="960" y="714" className="text-xs fill-red-700">
          • college
        </text>
        <text x="960" y="727" className="text-xs fill-red-700">
          • department_type
        </text>
      </g>

      {/* dim_semesters */}
      <g>
        <rect x="300" y="50" width="200" height="120" fill="#fce7f3" stroke="#ec4899" strokeWidth="2" rx="5" />
        <text x="400" y="75" textAnchor="middle" className="font-bold fill-pink-800">
          DIM_SEMESTERS
        </text>
        <text x="310" y="95" className="text-xs fill-pink-700">
          • semester_key (PK)
        </text>
        <text x="310" y="108" className="text-xs fill-pink-700">
          • semester_id
        </text>
        <text x="310" y="121" className="text-xs fill-pink-700">
          • semester_name
        </text>
        <text x="310" y="134" className="text-xs fill-pink-700">
          • year
        </text>
        <text x="310" y="147" className="text-xs fill-pink-700">
          • academic_year
        </text>
        <text x="310" y="160" className="text-xs fill-pink-700">
          • duration_days
        </text>
      </g>

      {/* dim_sections */}
      <g>
        <rect x="700" y="50" width="200" height="120" fill="#e0f2fe" stroke="#0891b2" strokeWidth="2" rx="5" />
        <text x="800" y="75" textAnchor="middle" className="font-bold fill-cyan-800">
          DIM_SECTIONS
        </text>
        <text x="710" y="95" className="text-xs fill-cyan-700">
          • section_key (PK)
        </text>
        <text x="710" y="108" className="text-xs fill-cyan-700">
          • section_id
        </text>
        <text x="710" y="121" className="text-xs fill-cyan-700">
          • section_number
        </text>
        <text x="710" y="134" className="text-xs fill-cyan-700">
          • max_capacity
        </text>
        <text x="710" y="147" className="text-xs fill-cyan-700">
          • schedule_days
        </text>
        <text x="710" y="160" className="text-xs fill-cyan-700">
          • delivery_mode
        </text>
      </g>

      {/* dim_date */}
      <g>
        <rect x="500" y="630" width="200" height="120" fill="#f0fdf4" stroke="#16a34a" strokeWidth="2" rx="5" />
        <text x="600" y="655" textAnchor="middle" className="font-bold fill-green-800">
          DIM_DATE
        </text>
        <text x="510" y="675" className="text-xs fill-green-700">
          • date_key (PK)
        </text>
        <text x="510" y="688" className="text-xs fill-green-700">
          • full_date
        </text>
        <text x="510" y="701" className="text-xs fill-green-700">
          • day_name
        </text>
        <text x="510" y="714" className="text-xs fill-green-700">
          • month_name
        </text>
        <text x="510" y="727" className="text-xs fill-green-700">
          • quarter
        </text>
        <text x="510" y="740" className="text-xs fill-green-700">
          • year
        </text>
      </g>

      {/* Relationship Lines */}
      {/* Students to Fact */}
      <line x1="250" y1="110" x2="450" y2="350" stroke="#374151" strokeWidth="2" />
      <circle cx="250" cy="110" r="3" fill="#3b82f6" />
      <circle cx="450" cy="350" r="3" fill="#f59e0b" />

      {/* Courses to Fact */}
      <line x1="950" y1="110" x2="750" y2="350" stroke="#374151" strokeWidth="2" />
      <circle cx="950" cy="110" r="3" fill="#22c55e" />
      <circle cx="750" cy="350" r="3" fill="#f59e0b" />

      {/* Faculty to Fact */}
      <line x1="250" y1="690" x2="450" y2="450" stroke="#374151" strokeWidth="2" />
      <circle cx="250" cy="690" r="3" fill="#a855f7" />
      <circle cx="450" cy="450" r="3" fill="#f59e0b" />

      {/* Departments to Fact */}
      <line x1="950" y1="690" x2="750" y2="450" stroke="#374151" strokeWidth="2" />
      <circle cx="950" cy="690" r="3" fill="#ef4444" />
      <circle cx="750" cy="450" r="3" fill="#f59e0b" />

      {/* Semesters to Fact */}
      <line x1="400" y1="170" x2="550" y2="300" stroke="#374151" strokeWidth="2" />
      <circle cx="400" cy="170" r="3" fill="#ec4899" />
      <circle cx="550" cy="300" r="3" fill="#f59e0b" />

      {/* Sections to Fact */}
      <line x1="800" y1="170" x2="650" y2="300" stroke="#374151" strokeWidth="2" />
      <circle cx="800" cy="170" r="3" fill="#0891b2" />
      <circle cx="650" cy="300" r="3" fill="#f59e0b" />

      {/* Date to Fact */}
      <line x1="600" y1="630" x2="600" y2="500" stroke="#374151" strokeWidth="2" />
      <circle cx="600" cy="630" r="3" fill="#16a34a" />
      <circle cx="600" cy="500" r="3" fill="#f59e0b" />

      {/* Star Schema Label */}
      <text x="600" y="780" textAnchor="middle" className="text-lg font-bold fill-gray-600">
        ⭐ Star Schema Design - Optimized for OLAP Operations
      </text>
    </svg>
  )
}
