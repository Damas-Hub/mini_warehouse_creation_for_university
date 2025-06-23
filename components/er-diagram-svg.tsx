export default function ERDiagramSVG() {
  return (
    <svg viewBox="0 0 1200 800" className="w-full h-auto border rounded-lg bg-white">
      {/* Background */}
      <rect width="1200" height="800" fill="#f8fafc" />

      {/* Title */}
      <text x="600" y="30" textAnchor="middle" className="text-xl font-bold fill-gray-800">
        University Course Registration System - ER Diagram
      </text>

      {/* Students Entity */}
      <g>
        <rect x="50" y="100" width="180" height="120" fill="#dbeafe" stroke="#3b82f6" strokeWidth="2" rx="5" />
        <text x="140" y="120" textAnchor="middle" className="font-bold fill-blue-800">
          STUDENTS
        </text>
        <text x="60" y="140" className="text-sm fill-blue-700">
          • student_id (PK)
        </text>
        <text x="60" y="155" className="text-sm fill-blue-700">
          • first_name
        </text>
        <text x="60" y="170" className="text-sm fill-blue-700">
          • last_name
        </text>
        <text x="60" y="185" className="text-sm fill-blue-700">
          • email
        </text>
        <text x="60" y="200" className="text-sm fill-blue-700">
          • gpa
        </text>
      </g>

      {/* Departments Entity */}
      <g>
        <rect x="300" y="100" width="180" height="120" fill="#dcfce7" stroke="#22c55e" strokeWidth="2" rx="5" />
        <text x="390" y="120" textAnchor="middle" className="font-bold fill-green-800">
          DEPARTMENTS
        </text>
        <text x="310" y="140" className="text-sm fill-green-700">
          • department_id (PK)
        </text>
        <text x="310" y="155" className="text-sm fill-green-700">
          • department_name
        </text>
        <text x="310" y="170" className="text-sm fill-green-700">
          • department_code
        </text>
        <text x="310" y="185" className="text-sm fill-green-700">
          • building
        </text>
        <text x="310" y="200" className="text-sm fill-green-700">
          • head_faculty_id (FK)
        </text>
      </g>

      {/* Faculty Entity */}
      <g>
        <rect x="550" y="100" width="180" height="120" fill="#f3e8ff" stroke="#a855f7" strokeWidth="2" rx="5" />
        <text x="640" y="120" textAnchor="middle" className="font-bold fill-purple-800">
          FACULTY
        </text>
        <text x="560" y="140" className="text-sm fill-purple-700">
          • faculty_id (PK)
        </text>
        <text x="560" y="155" className="text-sm fill-purple-700">
          • first_name
        </text>
        <text x="560" y="170" className="text-sm fill-purple-700">
          • last_name
        </text>
        <text x="560" y="185" className="text-sm fill-purple-700">
          • department_id (FK)
        </text>
        <text x="560" y="200" className="text-sm fill-purple-700">
          • position
        </text>
      </g>

      {/* Courses Entity */}
      <g>
        <rect x="800" y="100" width="180" height="120" fill="#fef3c7" stroke="#f59e0b" strokeWidth="2" rx="5" />
        <text x="890" y="120" textAnchor="middle" className="font-bold fill-amber-800">
          COURSES
        </text>
        <text x="810" y="140" className="text-sm fill-amber-700">
          • course_id (PK)
        </text>
        <text x="810" y="155" className="text-sm fill-amber-700">
          • course_code
        </text>
        <text x="810" y="170" className="text-sm fill-amber-700">
          • course_name
        </text>
        <text x="810" y="185" className="text-sm fill-amber-700">
          • credits
        </text>
        <text x="810" y="200" className="text-sm fill-amber-700">
          • department_id (FK)
        </text>
      </g>

      {/* Semesters Entity */}
      <g>
        <rect x="300" y="300" width="180" height="120" fill="#fce7f3" stroke="#ec4899" strokeWidth="2" rx="5" />
        <text x="390" y="320" textAnchor="middle" className="font-bold fill-pink-800">
          SEMESTERS
        </text>
        <text x="310" y="340" className="text-sm fill-pink-700">
          • semester_id (PK)
        </text>
        <text x="310" y="355" className="text-sm fill-pink-700">
          • semester_name
        </text>
        <text x="310" y="370" className="text-sm fill-pink-700">
          • year
        </text>
        <text x="310" y="385" className="text-sm fill-pink-700">
          • start_date
        </text>
        <text x="310" y="400" className="text-sm fill-pink-700">
          • end_date
        </text>
      </g>

      {/* Course Sections Entity */}
      <g>
        <rect x="550" y="300" width="180" height="140" fill="#e0f2fe" stroke="#0891b2" strokeWidth="2" rx="5" />
        <text x="640" y="320" textAnchor="middle" className="font-bold fill-cyan-800">
          COURSE_SECTIONS
        </text>
        <text x="560" y="340" className="text-sm fill-cyan-700">
          • section_id (PK)
        </text>
        <text x="560" y="355" className="text-sm fill-cyan-700">
          • course_id (FK)
        </text>
        <text x="560" y="370" className="text-sm fill-cyan-700">
          • faculty_id (FK)
        </text>
        <text x="560" y="385" className="text-sm fill-cyan-700">
          • semester_id (FK)
        </text>
        <text x="560" y="400" className="text-sm fill-cyan-700">
          • max_capacity
        </text>
        <text x="560" y="415" className="text-sm fill-cyan-700">
          • schedule_days
        </text>
      </g>

      {/* Enrollments Entity */}
      <g>
        <rect x="300" y="500" width="180" height="140" fill="#fef2f2" stroke="#ef4444" strokeWidth="2" rx="5" />
        <text x="390" y="520" textAnchor="middle" className="font-bold fill-red-800">
          ENROLLMENTS
        </text>
        <text x="310" y="540" className="text-sm fill-red-700">
          • enrollment_id (PK)
        </text>
        <text x="310" y="555" className="text-sm fill-red-700">
          • student_id (FK)
        </text>
        <text x="310" y="570" className="text-sm fill-red-700">
          • section_id (FK)
        </text>
        <text x="310" y="585" className="text-sm fill-red-700">
          • final_grade
        </text>
        <text x="310" y="600" className="text-sm fill-red-700">
          • letter_grade
        </text>
        <text x="310" y="615" className="text-sm fill-red-700">
          • status
        </text>
      </g>

      {/* Relationships */}
      {/* Department to Faculty */}
      <line x1="480" y1="160" x2="550" y2="160" stroke="#374151" strokeWidth="2" />
      <text x="515" y="155" textAnchor="middle" className="text-xs fill-gray-600">
        1:M
      </text>

      {/* Department to Courses */}
      <line x1="480" y1="180" x2="800" y2="180" stroke="#374151" strokeWidth="2" />
      <text x="640" y="175" textAnchor="middle" className="text-xs fill-gray-600">
        1:M
      </text>

      {/* Faculty to Course Sections */}
      <line x1="640" y1="220" x2="640" y2="300" stroke="#374151" strokeWidth="2" />
      <text x="650" y="260" className="text-xs fill-gray-600">
        1:M
      </text>

      {/* Courses to Course Sections */}
      <line x1="800" y1="220" x2="730" y2="300" stroke="#374151" strokeWidth="2" />
      <text x="765" y="260" className="text-xs fill-gray-600">
        1:M
      </text>

      {/* Semesters to Course Sections */}
      <line x1="480" y1="360" x2="550" y2="360" stroke="#374151" strokeWidth="2" />
      <text x="515" y="355" className="text-xs fill-gray-600">
        1:M
      </text>

      {/* Students to Enrollments */}
      <line x1="140" y1="220" x2="140" y2="480" x2="300" y2="570" stroke="#374151" strokeWidth="2" fill="none" />
      <text x="220" y="400" className="text-xs fill-gray-600">
        1:M
      </text>

      {/* Course Sections to Enrollments */}
      <line x1="550" y1="440" x2="480" y2="570" stroke="#374151" strokeWidth="2" />
      <text x="515" y="505" className="text-xs fill-gray-600">
        1:M
      </text>

      {/* Legend */}
      <g>
        <rect x="1000" y="500" width="180" height="120" fill="white" stroke="#d1d5db" strokeWidth="1" rx="5" />
        <text x="1090" y="520" textAnchor="middle" className="font-bold fill-gray-800">
          Legend
        </text>
        <text x="1010" y="540" className="text-sm fill-gray-700">
          PK = Primary Key
        </text>
        <text x="1010" y="555" className="text-sm fill-gray-700">
          FK = Foreign Key
        </text>
        <text x="1010" y="570" className="text-sm fill-gray-700">
          1:M = One to Many
        </text>
        <line x1="1010" y1="585" x2="1040" y2="585" stroke="#374151" strokeWidth="2" />
        <text x="1050" y="590" className="text-sm fill-gray-700">
          Relationship
        </text>
      </g>
    </svg>
  )
}
