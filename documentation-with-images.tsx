"use client"

import ERDiagramSVG from "@/components/er-diagram-svg"
import StarSchemaSVG from "@/components/star-schema-svg"
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card"
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs"
import { Badge } from "@/components/ui/badge"
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table"
import { Database, GitBranch, BarChart3, Search, Filter, TrendingUp } from "lucide-react"

export default function DocumentationWithImages() {
  const dataQualityMetrics = [
    { metric: "Completeness", score: 98.5, status: "excellent" },
    { metric: "Accuracy", score: 96.2, status: "excellent" },
    { metric: "Consistency", score: 94.8, status: "good" },
    { metric: "Timeliness", score: 92.1, status: "good" },
    { metric: "Validity", score: 97.3, status: "excellent" },
  ]

  const getStatusColor = (status: string) => {
    switch (status) {
      case "excellent":
        return "bg-green-500"
      case "good":
        return "bg-blue-500"
      case "warning":
        return "bg-yellow-500"
      case "poor":
        return "bg-red-500"
      default:
        return "bg-gray-500"
    }
  }

  return (
    <div className="min-h-screen bg-gray-50 p-6">
      <div className="max-w-7xl mx-auto space-y-6">
        {/* Header */}
        <div className="text-center space-y-4">
          <h1 className="text-4xl font-bold text-gray-900">University Data Warehouse</h1>
          <p className="text-xl text-gray-600">Complete Documentation with Visual Diagrams</p>
          <div className="flex justify-center space-x-2">
            <Badge variant="outline" className="bg-blue-50 text-blue-700 border-blue-200">
              <Database className="w-4 h-4 mr-1" />
              Star Schema Design
            </Badge>
            <Badge variant="outline" className="bg-green-50 text-green-700 border-green-200">
              <GitBranch className="w-4 h-4 mr-1" />
              OLAP Operations
            </Badge>
          </div>
        </div>

        <Tabs defaultValue="er-diagram" className="space-y-6">
          <TabsList className="grid w-full grid-cols-4">
            <TabsTrigger value="er-diagram">ER Diagram</TabsTrigger>
            <TabsTrigger value="star-schema">Star Schema</TabsTrigger>
            <TabsTrigger value="sql-examples">SQL Examples</TabsTrigger>
            <TabsTrigger value="olap-operations">OLAP Operations</TabsTrigger>
          </TabsList>

          {/* ER Diagram Tab */}
          <TabsContent value="er-diagram" className="space-y-6">
            <Card>
              <CardHeader>
                <CardTitle className="flex items-center">
                  <Database className="w-6 h-6 mr-2 text-blue-600" />
                  Operational Database ER Diagram
                </CardTitle>
                <CardDescription>
                  Entity-Relationship diagram showing the normalized operational database structure for the university
                  course registration system
                </CardDescription>
              </CardHeader>
              <CardContent>
                <div className="bg-white p-4 rounded-lg border shadow-sm">
                  <ERDiagramSVG />
                </div>

                <div className="mt-6 grid grid-cols-1 md:grid-cols-2 gap-4">
                  <div className="space-y-3">
                    <h4 className="font-semibold text-lg">Key Entities</h4>
                    <div className="space-y-2">
                      <div className="flex items-center space-x-2">
                        <div className="w-3 h-3 bg-blue-500 rounded"></div>
                        <span className="text-sm">
                          <strong>Students:</strong> Student information and academic status
                        </span>
                      </div>
                      <div className="flex items-center space-x-2">
                        <div className="w-3 h-3 bg-green-500 rounded"></div>
                        <span className="text-sm">
                          <strong>Courses:</strong> Course catalog and curriculum details
                        </span>
                      </div>
                      <div className="flex items-center space-x-2">
                        <div className="w-3 h-3 bg-purple-500 rounded"></div>
                        <span className="text-sm">
                          <strong>Faculty:</strong> Instructor information and assignments
                        </span>
                      </div>
                      <div className="flex items-center space-x-2">
                        <div className="w-3 h-3 bg-orange-500 rounded"></div>
                        <span className="text-sm">
                          <strong>Enrollments:</strong> Student-course registration records
                        </span>
                      </div>
                    </div>
                  </div>

                  <div className="space-y-3">
                    <h4 className="font-semibold text-lg">Key Relationships</h4>
                    <div className="space-y-2 text-sm">
                      <p>
                        • <strong>One-to-Many:</strong> Department → Faculty, Department → Courses
                      </p>
                      <p>
                        • <strong>Many-to-Many:</strong> Students ↔ Courses (via Enrollments)
                      </p>
                      <p>
                        • <strong>Associative Entity:</strong> Course_Sections links Courses, Faculty, Semesters
                      </p>
                      <p>
                        • <strong>Self-Referencing:</strong> Department head references Faculty
                      </p>
                    </div>
                  </div>
                </div>
              </CardContent>
            </Card>

            {/* Database Statistics */}
            <div className="grid grid-cols-1 md:grid-cols-4 gap-4">
              <Card>
                <CardContent className="pt-6">
                  <div className="text-2xl font-bold text-blue-600">8</div>
                  <p className="text-sm text-gray-600">Core Tables</p>
                </CardContent>
              </Card>
              <Card>
                <CardContent className="pt-6">
                  <div className="text-2xl font-bold text-green-600">12</div>
                  <p className="text-sm text-gray-600">Relationships</p>
                </CardContent>
              </Card>
              <Card>
                <CardContent className="pt-6">
                  <div className="text-2xl font-bold text-purple-600">15</div>
                  <p className="text-sm text-gray-600">Foreign Keys</p>
                </CardContent>
              </Card>
              <Card>
                <CardContent className="pt-6">
                  <div className="text-2xl font-bold text-orange-600">3NF</div>
                  <p className="text-sm text-gray-600">Normalization</p>
                </CardContent>
              </Card>
            </div>
          </TabsContent>

          {/* Star Schema Tab */}
          <TabsContent value="star-schema" className="space-y-6">
            <Card>
              <CardHeader>
                <CardTitle className="flex items-center">
                  <BarChart3 className="w-6 h-6 mr-2 text-green-600" />
                  Data Warehouse Star Schema
                </CardTitle>
                <CardDescription>
                  Dimensional model optimized for analytical queries and OLAP operations
                </CardDescription>
              </CardHeader>
              <CardContent>
                <div className="bg-white p-4 rounded-lg border shadow-sm">
                  <StarSchemaSVG />
                </div>

                <div className="mt-6 grid grid-cols-1 lg:grid-cols-2 gap-6">
                  <div className="space-y-4">
                    <h4 className="font-semibold text-lg">Fact Table</h4>
                    <div className="bg-blue-50 p-4 rounded-lg border border-blue-200">
                      <h5 className="font-medium text-blue-900 mb-2">fact_enrollments</h5>
                      <div className="space-y-1 text-sm text-blue-800">
                        <p>
                          <strong>Measures:</strong>
                        </p>
                        <ul className="list-disc list-inside ml-2 space-y-1">
                          <li>enrollment_count, final_grade</li>
                          <li>credits_attempted, credits_earned</li>
                          <li>gpa_points, days_to_completion</li>
                        </ul>
                        <p className="mt-2">
                          <strong>Flags:</strong>
                        </p>
                        <ul className="list-disc list-inside ml-2">
                          <li>is_passing, is_honors, is_repeat</li>
                        </ul>
                      </div>
                    </div>
                  </div>

                  <div className="space-y-4">
                    <h4 className="font-semibold text-lg">Dimension Tables</h4>
                    <div className="space-y-2">
                      {[
                        { name: "dim_students", desc: "Student demographics & academic status", color: "green" },
                        { name: "dim_courses", desc: "Course catalog & curriculum details", color: "purple" },
                        { name: "dim_faculty", desc: "Instructor profiles & qualifications", color: "orange" },
                        { name: "dim_departments", desc: "Academic departments & colleges", color: "red" },
                        { name: "dim_semesters", desc: "Academic calendar & time periods", color: "yellow" },
                        { name: "dim_sections", desc: "Course sections & scheduling", color: "indigo" },
                        { name: "dim_date", desc: "Date hierarchy for time analysis", color: "pink" },
                      ].map((dim, index) => (
                        <div key={index} className="bg-gray-50 p-3 rounded border border-gray-200">
                          <div className="flex justify-between items-center">
                            <span className="font-medium text-gray-900">{dim.name}</span>
                            <span className="text-xs text-gray-700">SCD Type 2</span>
                          </div>
                          <p className="text-sm text-gray-800 mt-1">{dim.desc}</p>
                        </div>
                      ))}
                    </div>
                  </div>
                </div>
              </CardContent>
            </Card>

            {/* Schema Benefits */}
            <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
              <Card>
                <CardHeader>
                  <CardTitle className="text-lg">Query Performance</CardTitle>
                </CardHeader>
                <CardContent>
                  <p className="text-sm text-gray-600">
                    Denormalized structure optimizes analytical queries with fewer joins and faster aggregations.
                  </p>
                </CardContent>
              </Card>
              <Card>
                <CardHeader>
                  <CardTitle className="text-lg">Historical Tracking</CardTitle>
                </CardHeader>
                <CardContent>
                  <p className="text-sm text-gray-600">
                    SCD Type 2 implementation maintains complete historical data for trend analysis.
                  </p>
                </CardContent>
              </Card>
              <Card>
                <CardHeader>
                  <CardTitle className="text-lg">Business Intelligence</CardTitle>
                </CardHeader>
                <CardContent>
                  <p className="text-sm text-gray-600">
                    Dimensional model supports OLAP operations and business intelligence tools.
                  </p>
                </CardContent>
              </Card>
            </div>
          </TabsContent>

          {/* SQL Examples Tab */}
          <TabsContent value="sql-examples" className="space-y-6">
            <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
              {/* Table Creation */}
              <Card>
                <CardHeader>
                  <CardTitle>Table Creation Examples</CardTitle>
                  <CardDescription>SQL DDL for operational and warehouse tables</CardDescription>
                </CardHeader>
                <CardContent>
                  <div className="space-y-4">
                    <div>
                      <h5 className="font-medium mb-2">Operational Table</h5>
                      <pre className="bg-gray-100 p-3 rounded text-xs overflow-x-auto">
                        {`CREATE TABLE students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    date_of_birth DATE,
    enrollment_date DATE,
    gpa DECIMAL(3,2) DEFAULT 0.00,
    total_credits INT DEFAULT 0,
    status VARCHAR(20) DEFAULT 'Active'
);`}
                      </pre>
                    </div>
                    <div>
                      <h5 className="font-medium mb-2">Dimension Table</h5>
                      <pre className="bg-gray-100 p-3 rounded text-xs overflow-x-auto">
                        {`CREATE TABLE dim_students (
    student_key INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    full_name VARCHAR(101),
    age_group VARCHAR(20),
    class_level VARCHAR(20),
    effective_date DATE,
    expiry_date DATE,
    is_current BOOLEAN DEFAULT TRUE
);`}
                      </pre>
                    </div>
                  </div>
                </CardContent>
              </Card>

              {/* Data Loading */}
              <Card>
                <CardHeader>
                  <CardTitle>Data Loading Examples</CardTitle>
                  <CardDescription>Sample data insertion and ETL processes</CardDescription>
                </CardHeader>
                <CardContent>
                  <div className="space-y-4">
                    <div>
                      <h5 className="font-medium mb-2">Sample Data Insert</h5>
                      <pre className="bg-gray-100 p-3 rounded text-xs overflow-x-auto">
                        {`INSERT INTO students (
    first_name, last_name, email, 
    date_of_birth, enrollment_date, 
    gpa, total_credits
) VALUES
('Alice', 'Cooper', 'alice@student.edu', 
 '2002-03-15', '2020-08-25', 3.75, 45),
('Bob', 'Miller', 'bob@student.edu', 
 '2001-07-22', '2020-08-25', 3.20, 48);`}
                      </pre>
                    </div>
                    <div>
                      <h5 className="font-medium mb-2">ETL Transformation</h5>
                      <pre className="bg-gray-100 p-3 rounded text-xs overflow-x-auto">
                        {`INSERT INTO dim_students (
    student_id, full_name, age_group, 
    class_level, effective_date
)
SELECT 
    s.student_id,
    CONCAT(s.first_name, ' ', s.last_name),
    CASE 
        WHEN age < 20 THEN 'Under 20'
        WHEN age BETWEEN 20 AND 22 THEN '20-22'
        ELSE 'Over 22'
    END,
    CASE 
        WHEN total_credits < 30 THEN 'Freshman'
        WHEN total_credits < 60 THEN 'Sophomore'
        ELSE 'Junior+'
    END,
    CURRENT_DATE
FROM students s;`}
                      </pre>
                    </div>
                  </div>
                </CardContent>
              </Card>
            </div>

            {/* Data Quality Metrics */}
            <Card>
              <CardHeader>
                <CardTitle>Data Quality Metrics</CardTitle>
                <CardDescription>Current database statistics and quality indicators</CardDescription>
              </CardHeader>
              <CardContent>
                <Table>
                  <TableHeader>
                    <TableRow>
                      <TableHead>Table</TableHead>
                      <TableHead className="text-right">Records</TableHead>
                      <TableHead className="text-right">Size (MB)</TableHead>
                      <TableHead>Completeness</TableHead>
                      <TableHead>Last Updated</TableHead>
                    </TableRow>
                  </TableHeader>
                  <TableBody>
                    <TableRow>
                      <TableCell className="font-medium">fact_enrollments</TableCell>
                      <TableCell className="text-right">586</TableCell>
                      <TableCell className="text-right">15.2</TableCell>
                      <TableCell>
                        <Badge variant="default">98.5%</Badge>
                      </TableCell>
                      <TableCell>2024-01-15 14:30</TableCell>
                    </TableRow>
                    <TableRow>
                      <TableCell className="font-medium">dim_students</TableCell>
                      <TableCell className="text-right">10</TableCell>
                      <TableCell className="text-right">2.1</TableCell>
                      <TableCell>
                        <Badge variant="default">100%</Badge>
                      </TableCell>
                      <TableCell>2024-01-15 14:25</TableCell>
                    </TableRow>
                    <TableRow>
                      <TableCell className="font-medium">dim_courses</TableCell>
                      <TableCell className="text-right">12</TableCell>
                      <TableCell className="text-right">1.8</TableCell>
                      <TableCell>
                        <Badge variant="default">100%</Badge>
                      </TableCell>
                      <TableCell>2024-01-15 14:25</TableCell>
                    </TableRow>
                  </TableBody>
                </Table>
              </CardContent>
            </Card>
          </TabsContent>

          {/* OLAP Operations Tab */}
          <TabsContent value="olap-operations" className="space-y-6">
            <div className="grid grid-cols-1 md:grid-cols-3 gap-4 mb-6">
              <Card>
                <CardHeader>
                  <CardTitle className="flex items-center text-lg">
                    <TrendingUp className="w-5 h-5 mr-2 text-blue-600" />
                    Roll-up
                  </CardTitle>
                </CardHeader>
                <CardContent>
                  <p className="text-sm text-gray-600">
                    Aggregate data from detailed to summary levels (e.g., individual grades → department averages)
                  </p>
                </CardContent>
              </Card>
              <Card>
                <CardHeader>
                  <CardTitle className="flex items-center text-lg">
                    <Search className="w-5 h-5 mr-2 text-green-600" />
                    Drill-down
                  </CardTitle>
                </CardHeader>
                <CardContent>
                  <p className="text-sm text-gray-600">
                    Break down summary data to detailed views (e.g., department performance → individual courses)
                  </p>
                </CardContent>
              </Card>
              <Card>
                <CardHeader>
                  <CardTitle className="flex items-center text-lg">
                    <Filter className="w-5 h-5 mr-2 text-purple-600" />
                    Slice & Dice
                  </CardTitle>
                </CardHeader>
                <CardContent>
                  <p className="text-sm text-gray-600">Filter and cross-tabulate data across multiple dimensions</p>
                </CardContent>
              </Card>
            </div>

            {/* Roll-up Example */}
            <Card>
              <CardHeader>
                <CardTitle className="flex items-center">
                  <TrendingUp className="w-5 h-5 mr-2 text-blue-600" />
                  Roll-up Operation Example
                </CardTitle>
                <CardDescription>
                  Aggregating enrollment data from individual records to department level
                </CardDescription>
              </CardHeader>
              <CardContent>
                <pre className="bg-gray-100 p-4 rounded text-sm overflow-x-auto">
                  {`-- Roll-up: Department level enrollment summary by year
SELECT 
    dd.department_name,
    dsem.year,
    COUNT(*) as total_enrollments,
    AVG(f.final_grade) as avg_grade,
    SUM(f.credits_earned) as total_credits_earned,
    ROUND((SUM(CASE WHEN f.is_passing THEN 1 ELSE 0 END) / COUNT(*)) * 100, 2) as pass_rate
FROM fact_enrollments f
JOIN dim_departments dd ON f.department_key = dd.department_key
JOIN dim_semesters dsem ON f.semester_key = dsem.semester_key
WHERE f.completion_status = 'Completed'
GROUP BY dd.department_name, dsem.year
ORDER BY dd.department_name, dsem.year;`}
                </pre>
                <div className="mt-4 p-3 bg-blue-50 rounded border border-blue-200">
                  <p className="text-sm text-blue-800">
                    <strong>Result:</strong> Shows aggregated metrics by department and year, rolling up from individual
                    enrollment records.
                  </p>
                </div>
              </CardContent>
            </Card>

            {/* Drill-down Example */}
            <Card>
              <CardHeader>
                <CardTitle className="flex items-center">
                  <Search className="w-5 h-5 mr-2 text-green-600" />
                  Drill-down Operation Example
                </CardTitle>
                <CardDescription>Breaking down department performance to individual course level</CardDescription>
              </CardHeader>
              <CardContent>
                <pre className="bg-gray-100 p-4 rounded text-sm overflow-x-auto">
                  {`-- Drill-down: From department to course level analysis
SELECT 
    dd.department_name,
    dc.course_code,
    dc.course_name,
    dc.credits,
    COUNT(*) as enrollments,
    AVG(f.final_grade) as avg_grade,
    MIN(f.final_grade) as min_grade,
    MAX(f.final_grade) as max_grade,
    STDDEV(f.final_grade) as grade_stddev
FROM fact_enrollments f
JOIN dim_departments dd ON f.department_key = dd.department_key
JOIN dim_courses dc ON f.course_key = dc.course_key
WHERE f.completion_status = 'Completed'
  AND dd.department_name = 'Computer Science'
GROUP BY dd.department_name, dc.course_code, dc.course_name, dc.credits
ORDER BY dc.course_code;`}
                </pre>
                <div className="mt-4 p-3 bg-green-50 rounded border border-green-200">
                  <p className="text-sm text-green-800">
                    <strong>Result:</strong> Detailed course-level performance within Computer Science department.
                  </p>
                </div>
              </CardContent>
            </Card>

            {/* Slice & Dice Example */}
            <Card>
              <CardHeader>
                <CardTitle className="flex items-center">
                  <Filter className="w-5 h-5 mr-2 text-purple-600" />
                  Slice & Dice Operation Example
                </CardTitle>
                <CardDescription>Cross-tabulation analysis across multiple dimensions</CardDescription>
              </CardHeader>
              <CardContent>
                <pre className="bg-gray-100 p-4 rounded text-sm overflow-x-auto">
                  {`-- Dice: Cross-tabulation of department vs semester performance
SELECT 
    dd.department_name,
    SUM(CASE WHEN dsem.semester_name = 'First Semester' AND dsem.year = 2022 THEN 1 ELSE 0 END) as first_sem_2022,
    SUM(CASE WHEN dsem.semester_name = 'Second Semester' AND dsem.year = 2022 THEN 1 ELSE 0 END) as second_sem_2022,
    SUM(CASE WHEN dsem.semester_name = 'First Semester' AND dsem.year = 2023 THEN 1 ELSE 0 END) as first_sem_2023,
    COUNT(*) as total_enrollments
FROM fact_enrollments f
JOIN dim_departments dd ON f.department_key = dd.department_key
JOIN dim_semesters dsem ON f.semester_key = dsem.semester_key
WHERE f.completion_status = 'Completed'
GROUP BY dd.department_name
ORDER BY total_enrollments DESC;`}
                </pre>
                <div className="mt-4 p-3 bg-purple-50 rounded border border-purple-200">
                  <p className="text-sm text-purple-800">
                    <strong>Result:</strong> Matrix view showing enrollment counts across departments and semesters.
                  </p>
                </div>
              </CardContent>
            </Card>

            {/* OLAP Benefits */}
            <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
              <Card>
                <CardHeader>
                  <CardTitle>Performance Benefits</CardTitle>
                </CardHeader>
                <CardContent className="space-y-2 text-sm">
                  <p>
                    • <strong>Pre-aggregated data:</strong> Faster query response times
                  </p>
                  <p>
                    • <strong>Indexed dimensions:</strong> Optimized join performance
                  </p>
                  <p>
                    • <strong>Columnar storage:</strong> Efficient analytical processing
                  </p>
                  <p>
                    • <strong>Materialized views:</strong> Common aggregations pre-computed
                  </p>
                </CardContent>
              </Card>
              <Card>
                <CardHeader>
                  <CardTitle>Analytical Capabilities</CardTitle>
                </CardHeader>
                <CardContent className="space-y-2 text-sm">
                  <p>
                    • <strong>Time series analysis:</strong> Trend identification and forecasting
                  </p>
                  <p>
                    • <strong>Comparative analysis:</strong> Period-over-period comparisons
                  </p>
                  <p>
                    • <strong>Statistical functions:</strong> Advanced mathematical operations
                  </p>
                  <p>
                    • <strong>What-if scenarios:</strong> Predictive modeling support
                  </p>
                </CardContent>
              </Card>
            </div>
          </TabsContent>
        </Tabs>
      </div>
    </div>
  )
}
