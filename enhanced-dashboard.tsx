"use client"

import type React from "react"
import { useState, useMemo } from "react"
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card"
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs"
import { Badge } from "@/components/ui/badge"
import { Button } from "@/components/ui/button"
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table"
import { Input } from "@/components/ui/input"
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select"
import {
  BarChart,
  Bar,
  XAxis,
  YAxis,
  CartesianGrid,
  Tooltip,
  Legend,
  ResponsiveContainer,
  LineChart,
  Line,
  PieChart,
  Pie,
  Cell,
  AreaChart,
  Area,
  RadarChart,
  PolarGrid,
  PolarAngleAxis,
  PolarRadiusAxis,
  Radar,
} from "recharts"
import { 
  Database, 
  Users, 
  BookOpen, 
  GraduationCap, 
  TrendingUp, 
  AlertTriangle, 
  CheckCircle, 
  Info, 
  X,
  Filter,
  BarChart3,
  Target,
  Award,
  Clock,
  Calendar
} from "lucide-react"

export default function EnhancedDashboard() {
  const [activeTab, setActiveTab] = useState("overview")
  const [selectedDepartment, setSelectedDepartment] = useState("all")
  const [selectedSemester, setSelectedSemester] = useState("all")
  const [selectedClassLevel, setSelectedClassLevel] = useState("all")

  // Enhanced sample data with more realistic analytics
  const [students, setStudents] = useState([
    {
      id: 1,
      name: "Alice Cooper",
      email: "alice.cooper@student.edu",
      age: 21,
      classLevel: "Junior",
      gpa: 3.75,
      totalCredits: 45,
      department: "Computer Science",
      enrollmentDate: "2020-08-25",
      retentionRate: 95,
      avgGrade: 89.2,
    },
    {
      id: 2,
      name: "Bob Miller",
      email: "bob.miller@student.edu",
      age: 22,
      classLevel: "Senior",
      gpa: 3.2,
      totalCredits: 48,
      department: "Mathematics",
      enrollmentDate: "2020-08-25",
      retentionRate: 88,
      avgGrade: 82.5,
    },
    {
      id: 3,
      name: "Carol White",
      email: "carol.white@student.edu",
      age: 21,
      classLevel: "Junior",
      gpa: 3.9,
      totalCredits: 42,
      department: "Computer Science",
      enrollmentDate: "2020-08-25",
      retentionRate: 92,
      avgGrade: 91.8,
    },
    {
      id: 4,
      name: "Daniel Lee",
      email: "daniel.lee@student.edu",
      age: 22,
      classLevel: "Senior",
      gpa: 2.85,
      totalCredits: 39,
      department: "Business Administration",
      enrollmentDate: "2020-08-25",
      retentionRate: 75,
      avgGrade: 78.3,
    },
    {
      id: 5,
      name: "Eva Thompson",
      email: "eva.thompson@student.edu",
      age: 20,
      classLevel: "Sophomore",
      gpa: 3.6,
      totalCredits: 30,
      department: "Psychology",
      enrollmentDate: "2021-08-23",
      retentionRate: 90,
      avgGrade: 85.7,
    },
    {
      id: 6,
      name: "Frank Garcia",
      email: "frank.garcia@student.edu",
      age: 19,
      classLevel: "Freshman",
      gpa: 3.4,
      totalCredits: 18,
      department: "Engineering",
      enrollmentDate: "2022-08-22",
      retentionRate: 85,
      avgGrade: 83.2,
    },
  ])

  const [enrollments, setEnrollments] = useState([
    {
      id: 1,
      studentId: 1,
      studentName: "Alice Cooper",
      courseCode: "CS101",
      courseName: "Introduction to Programming",
      semester: "Fall 2023",
      grade: 89.5,
      letterGrade: "B+",
      credits: 3,
      status: "Completed",
      department: "Computer Science",
    },
    {
      id: 2,
      studentId: 1,
      studentName: "Alice Cooper",
      courseCode: "MATH101",
      courseName: "Calculus I",
      semester: "Fall 2023",
      grade: 92.0,
      letterGrade: "A-",
      credits: 4,
      status: "Completed",
      department: "Mathematics",
    },
    {
      id: 3,
      studentId: 2,
      studentName: "Bob Miller",
      courseCode: "CS101",
      courseName: "Introduction to Programming",
      semester: "Fall 2023",
      grade: 78.5,
      letterGrade: "C+",
      credits: 3,
      status: "Completed",
      department: "Computer Science",
    },
    {
      id: 4,
      studentId: 3,
      studentName: "Carol White",
      courseCode: "CS201",
      courseName: "Data Structures",
      semester: "Fall 2023",
      grade: 96.5,
      letterGrade: "A",
      credits: 4,
      status: "Completed",
      department: "Computer Science",
    },
    {
      id: 5,
      studentId: 4,
      studentName: "Daniel Lee",
      courseCode: "BUS101",
      courseName: "Introduction to Business",
      semester: "Fall 2023",
      grade: 82.0,
      letterGrade: "B-",
      credits: 3,
      status: "Completed",
      department: "Business Administration",
    },
    {
      id: 6,
      studentId: 5,
      studentName: "Eva Thompson",
      courseCode: "PSY101",
      courseName: "Introduction to Psychology",
      semester: "Fall 2023",
      grade: 88.5,
      letterGrade: "B+",
      credits: 3,
      status: "Completed",
      department: "Psychology",
    },
  ])

  const [courses] = useState([
    { code: "CS101", name: "Introduction to Programming", credits: 3, department: "Computer Science", enrollment: 45, avgGrade: 85.2 },
    { code: "CS201", name: "Data Structures", credits: 4, department: "Computer Science", enrollment: 32, avgGrade: 87.8 },
    { code: "CS301", name: "Database Systems", credits: 3, department: "Computer Science", enrollment: 28, avgGrade: 83.5 },
    { code: "MATH101", name: "Calculus I", credits: 4, department: "Mathematics", enrollment: 52, avgGrade: 79.8 },
    { code: "MATH201", name: "Calculus II", credits: 4, department: "Mathematics", enrollment: 38, avgGrade: 81.2 },
    { code: "BUS101", name: "Introduction to Business", credits: 3, department: "Business Administration", enrollment: 65, avgGrade: 82.5 },
    { code: "PSY101", name: "Introduction to Psychology", credits: 3, department: "Psychology", enrollment: 42, avgGrade: 84.7 },
  ])

  // Enhanced analytics data
  const departmentPerformance = [
    { department: "Computer Science", avgGrade: 85.5, passRate: 92, enrollment: 105, retention: 94 },
    { department: "Mathematics", avgGrade: 80.5, passRate: 88, enrollment: 90, retention: 89 },
    { department: "Business Administration", avgGrade: 82.5, passRate: 90, enrollment: 65, retention: 87 },
    { department: "Psychology", avgGrade: 84.7, passRate: 91, enrollment: 42, retention: 92 },
    { department: "Engineering", avgGrade: 83.2, passRate: 89, enrollment: 78, retention: 91 },
  ]

  const semesterTrends = [
    { semester: "Fall 2022", enrollments: 245, avgGrade: 82.1, passRate: 89 },
    { semester: "Spring 2023", enrollments: 268, avgGrade: 83.5, passRate: 91 },
    { semester: "Fall 2023", enrollments: 285, avgGrade: 84.2, passRate: 92 },
    { semester: "Spring 2024", enrollments: 302, avgGrade: 85.1, passRate: 93 },
  ]

  const classLevelPerformance = [
    { level: "Freshman", avgGrade: 81.2, enrollment: 85, retention: 88 },
    { level: "Sophomore", avgGrade: 83.5, enrollment: 92, retention: 91 },
    { level: "Junior", avgGrade: 85.8, enrollment: 78, retention: 94 },
    { level: "Senior", avgGrade: 87.2, enrollment: 65, retention: 96 },
  ]

  // Filtered data based on selections
  const filteredStudents = useMemo(() => {
    return students.filter(student => {
      const deptMatch = selectedDepartment === "all" || student.department === selectedDepartment
      const levelMatch = selectedClassLevel === "all" || student.classLevel === selectedClassLevel
      return deptMatch && levelMatch
    })
  }, [students, selectedDepartment, selectedClassLevel])

  const filteredEnrollments = useMemo(() => {
    return enrollments.filter(enrollment => {
      const deptMatch = selectedDepartment === "all" || enrollment.department === selectedDepartment
      const semesterMatch = selectedSemester === "all" || enrollment.semester === selectedSemester
      return deptMatch && semesterMatch
    })
  }, [enrollments, selectedDepartment, selectedSemester])

  // Analytics calculations
  const overallStats = useMemo(() => {
    const totalStudents = filteredStudents.length
    const totalEnrollments = filteredEnrollments.length
    const avgGPA = totalStudents > 0 ? (filteredStudents.reduce((sum, s) => sum + s.gpa, 0) / totalStudents).toFixed(2) : 0
    const avgGrade = totalEnrollments > 0 ? (filteredEnrollments.reduce((sum, e) => sum + e.grade, 0) / totalEnrollments).toFixed(1) : 0
    const passRate = totalEnrollments > 0 ? Math.round((filteredEnrollments.filter(e => e.grade >= 60).length / totalEnrollments) * 100) : 0

    return { totalStudents, totalEnrollments, avgGPA, avgGrade, passRate }
  }, [filteredStudents, filteredEnrollments])

  const COLORS = ['#0088FE', '#00C49F', '#FFBB28', '#FF8042', '#8884D8', '#82CA9D']

  const getGradeColor = (grade: number) => {
    if (grade >= 90) return "text-green-600"
    if (grade >= 80) return "text-blue-600"
    if (grade >= 70) return "text-yellow-600"
    return "text-red-600"
  }

  const getStatusColor = (status: string) => {
    switch (status) {
      case "Completed":
        return "bg-green-100 text-green-800"
      case "Enrolled":
        return "bg-blue-100 text-blue-800"
      case "Withdrawn":
        return "bg-red-100 text-red-800"
      default:
        return "bg-gray-100 text-gray-800"
    }
  }

  return (
    <div className="min-h-screen bg-gray-50 p-6">
      <div className="max-w-7xl mx-auto space-y-6">
        {/* Header */}
        <div className="flex justify-between items-center">
          <div>
            <h1 className="text-3xl font-bold text-gray-900">Enhanced Data Warehouse Dashboard</h1>
            <p className="text-gray-600">Advanced analytics and real-time data management</p>
          </div>
          <div className="flex space-x-2">
            <Button>
              <Users className="w-4 h-4 mr-2" />
              Add Student
            </Button>
            <Button variant="outline">
              <BookOpen className="w-4 h-4 mr-2" />
              Add Enrollment
            </Button>
          </div>
        </div>

        {/* Filters */}
        <Card>
          <CardHeader>
            <CardTitle className="flex items-center">
              <Filter className="w-5 h-5 mr-2" />
              Interactive Filters
            </CardTitle>
          </CardHeader>
          <CardContent>
            <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
              <Select value={selectedDepartment} onValueChange={setSelectedDepartment}>
                <SelectTrigger>
                  <SelectValue placeholder="Select Department" />
                </SelectTrigger>
                <SelectContent>
                  <SelectItem value="all">All Departments</SelectItem>
                  <SelectItem value="Computer Science">Computer Science</SelectItem>
                  <SelectItem value="Mathematics">Mathematics</SelectItem>
                  <SelectItem value="Business Administration">Business Administration</SelectItem>
                  <SelectItem value="Psychology">Psychology</SelectItem>
                  <SelectItem value="Engineering">Engineering</SelectItem>
                </SelectContent>
              </Select>

              <Select value={selectedSemester} onValueChange={setSelectedSemester}>
                <SelectTrigger>
                  <SelectValue placeholder="Select Semester" />
                </SelectTrigger>
                <SelectContent>
                  <SelectItem value="all">All Semesters</SelectItem>
                  <SelectItem value="Fall 2023">Fall 2023</SelectItem>
                  <SelectItem value="Spring 2024">Spring 2024</SelectItem>
                </SelectContent>
              </Select>

              <Select value={selectedClassLevel} onValueChange={setSelectedClassLevel}>
                <SelectTrigger>
                  <SelectValue placeholder="Select Class Level" />
                </SelectTrigger>
                <SelectContent>
                  <SelectItem value="all">All Levels</SelectItem>
                  <SelectItem value="Freshman">Freshman</SelectItem>
                  <SelectItem value="Sophomore">Sophomore</SelectItem>
                  <SelectItem value="Junior">Junior</SelectItem>
                  <SelectItem value="Senior">Senior</SelectItem>
                </SelectContent>
              </Select>
            </div>
          </CardContent>
        </Card>

        {/* Overview Stats */}
        <div className="grid grid-cols-1 md:grid-cols-5 gap-4">
          <Card>
            <CardContent className="pt-6">
              <div className="flex items-center space-x-2">
                <Users className="w-5 h-5 text-blue-600" />
                <div>
                  <div className="text-2xl font-bold text-blue-600">{overallStats.totalStudents}</div>
                  <p className="text-sm text-gray-600">Total Students</p>
                </div>
              </div>
            </CardContent>
          </Card>

          <Card>
            <CardContent className="pt-6">
              <div className="flex items-center space-x-2">
                <BookOpen className="w-5 h-5 text-green-600" />
                <div>
                  <div className="text-2xl font-bold text-green-600">{overallStats.totalEnrollments}</div>
                  <p className="text-sm text-gray-600">Enrollments</p>
                </div>
              </div>
            </CardContent>
          </Card>

          <Card>
            <CardContent className="pt-6">
              <div className="flex items-center space-x-2">
                <Target className="w-5 h-5 text-purple-600" />
                <div>
                  <div className="text-2xl font-bold text-purple-600">{overallStats.avgGPA}</div>
                  <p className="text-sm text-gray-600">Avg GPA</p>
                </div>
              </div>
            </CardContent>
          </Card>

          <Card>
            <CardContent className="pt-6">
              <div className="flex items-center space-x-2">
                <Award className="w-5 h-5 text-orange-600" />
                <div>
                  <div className="text-2xl font-bold text-orange-600">{overallStats.avgGrade}%</div>
                  <p className="text-sm text-gray-600">Avg Grade</p>
                </div>
              </div>
            </CardContent>
          </Card>

          <Card>
            <CardContent className="pt-6">
              <div className="flex items-center space-x-2">
                <CheckCircle className="w-5 h-5 text-green-600" />
                <div>
                  <div className="text-2xl font-bold text-green-600">{overallStats.passRate}%</div>
                  <p className="text-sm text-gray-600">Pass Rate</p>
                </div>
              </div>
            </CardContent>
          </Card>
        </div>

        {/* Main Content Tabs */}
        <Tabs value={activeTab} onValueChange={setActiveTab} className="space-y-6">
          <TabsList className="grid w-full grid-cols-6">
            <TabsTrigger value="overview">Overview</TabsTrigger>
            <TabsTrigger value="analytics">Analytics</TabsTrigger>
            <TabsTrigger value="performance">Performance</TabsTrigger>
            <TabsTrigger value="trends">Trends</TabsTrigger>
            <TabsTrigger value="students">Students</TabsTrigger>
            <TabsTrigger value="enrollments">Enrollments</TabsTrigger>
          </TabsList>

          {/* Overview Tab */}
          <TabsContent value="overview" className="space-y-6">
            <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
              {/* Department Performance */}
              <Card>
                <CardHeader>
                  <CardTitle>Department Performance</CardTitle>
                  <CardDescription>Average grades and pass rates by department</CardDescription>
                </CardHeader>
                <CardContent>
                  <ResponsiveContainer width="100%" height={300}>
                    <BarChart data={departmentPerformance}>
                      <CartesianGrid strokeDasharray="3 3" />
                      <XAxis dataKey="department" />
                      <YAxis />
                      <Tooltip />
                      <Legend />
                      <Bar dataKey="avgGrade" fill="#8884d8" name="Avg Grade" />
                      <Bar dataKey="passRate" fill="#82ca9d" name="Pass Rate %" />
                    </BarChart>
                  </ResponsiveContainer>
                </CardContent>
              </Card>

              {/* Enrollment Distribution */}
              <Card>
                <CardHeader>
                  <CardTitle>Enrollment Distribution</CardTitle>
                  <CardDescription>Student distribution across departments</CardDescription>
                </CardHeader>
                <CardContent>
                  <ResponsiveContainer width="100%" height={300}>
                    <PieChart>
                      <Pie
                        data={departmentPerformance}
                        cx="50%"
                        cy="50%"
                        labelLine={false}
                        label={({ department, enrollment }) => `${department}: ${enrollment}`}
                        outerRadius={80}
                        fill="#8884d8"
                        dataKey="enrollment"
                      >
                        {departmentPerformance.map((entry, index) => (
                          <Cell key={`cell-${index}`} fill={COLORS[index % COLORS.length]} />
                        ))}
                      </Pie>
                      <Tooltip />
                    </PieChart>
                  </ResponsiveContainer>
                </CardContent>
              </Card>
            </div>
          </TabsContent>

          {/* Analytics Tab */}
          <TabsContent value="analytics" className="space-y-6">
            <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
              {/* Semester Trends */}
              <Card>
                <CardHeader>
                  <CardTitle>Semester Trends</CardTitle>
                  <CardDescription>Enrollment and performance trends over time</CardDescription>
                </CardHeader>
                <CardContent>
                  <ResponsiveContainer width="100%" height={300}>
                    <LineChart data={semesterTrends}>
                      <CartesianGrid strokeDasharray="3 3" />
                      <XAxis dataKey="semester" />
                      <YAxis yAxisId="left" />
                      <YAxis yAxisId="right" orientation="right" />
                      <Tooltip />
                      <Legend />
                      <Line yAxisId="left" type="monotone" dataKey="enrollments" stroke="#8884d8" name="Enrollments" />
                      <Line yAxisId="right" type="monotone" dataKey="avgGrade" stroke="#82ca9d" name="Avg Grade" />
                    </LineChart>
                  </ResponsiveContainer>
                </CardContent>
              </Card>

              {/* Class Level Performance */}
              <Card>
                <CardHeader>
                  <CardTitle>Class Level Performance</CardTitle>
                  <CardDescription>Performance metrics by student class level</CardDescription>
                </CardHeader>
                <CardContent>
                  <ResponsiveContainer width="100%" height={300}>
                    <BarChart data={classLevelPerformance}>
                      <CartesianGrid strokeDasharray="3 3" />
                      <XAxis dataKey="level" />
                      <YAxis />
                      <Tooltip />
                      <Legend />
                      <Bar dataKey="avgGrade" fill="#8884d8" name="Avg Grade" />
                      <Bar dataKey="retention" fill="#82ca9d" name="Retention %" />
                    </BarChart>
                  </ResponsiveContainer>
                </CardContent>
              </Card>
            </div>
          </TabsContent>

          {/* Performance Tab */}
          <TabsContent value="performance" className="space-y-6">
            <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
              {/* Department Radar Chart */}
              <Card>
                <CardHeader>
                  <CardTitle>Department Performance Radar</CardTitle>
                  <CardDescription>Multi-dimensional performance comparison</CardDescription>
                </CardHeader>
                <CardContent>
                  <ResponsiveContainer width="100%" height={300}>
                    <RadarChart data={departmentPerformance}>
                      <PolarGrid />
                      <PolarAngleAxis dataKey="department" />
                      <PolarRadiusAxis />
                      <Radar name="Performance" dataKey="avgGrade" stroke="#8884d8" fill="#8884d8" fillOpacity={0.6} />
                      <Radar name="Retention" dataKey="retention" stroke="#82ca9d" fill="#82ca9d" fillOpacity={0.6} />
                      <Legend />
                    </RadarChart>
                  </ResponsiveContainer>
                </CardContent>
              </Card>

              {/* Course Performance */}
              <Card>
                <CardHeader>
                  <CardTitle>Course Performance</CardTitle>
                  <CardDescription>Enrollment and average grades by course</CardDescription>
                </CardHeader>
                <CardContent>
                  <ResponsiveContainer width="100%" height={300}>
                    <AreaChart data={courses}>
                      <CartesianGrid strokeDasharray="3 3" />
                      <XAxis dataKey="code" />
                      <YAxis />
                      <Tooltip />
                      <Legend />
                      <Area type="monotone" dataKey="enrollment" stackId="1" stroke="#8884d8" fill="#8884d8" />
                      <Area type="monotone" dataKey="avgGrade" stackId="2" stroke="#82ca9d" fill="#82ca9d" />
                    </AreaChart>
                  </ResponsiveContainer>
                </CardContent>
              </Card>
            </div>
          </TabsContent>

          {/* Trends Tab */}
          <TabsContent value="trends" className="space-y-6">
            <Card>
              <CardHeader>
                <CardTitle>Performance Trends</CardTitle>
                <CardDescription>Historical performance and enrollment trends</CardDescription>
              </CardHeader>
              <CardContent>
                <ResponsiveContainer width="100%" height={400}>
                  <LineChart data={semesterTrends}>
                    <CartesianGrid strokeDasharray="3 3" />
                    <XAxis dataKey="semester" />
                    <YAxis yAxisId="left" />
                    <YAxis yAxisId="right" orientation="right" />
                    <Tooltip />
                    <Legend />
                    <Line yAxisId="left" type="monotone" dataKey="enrollments" stroke="#8884d8" strokeWidth={2} name="Enrollments" />
                    <Line yAxisId="right" type="monotone" dataKey="avgGrade" stroke="#82ca9d" strokeWidth={2} name="Avg Grade" />
                    <Line yAxisId="right" type="monotone" dataKey="passRate" stroke="#ffc658" strokeWidth={2} name="Pass Rate %" />
                  </LineChart>
                </ResponsiveContainer>
              </CardContent>
            </Card>
          </TabsContent>

          {/* Students Tab */}
          <TabsContent value="students" className="space-y-6">
            <Card>
              <CardHeader>
                <CardTitle>Student Directory</CardTitle>
                <CardDescription>Comprehensive student information and performance</CardDescription>
              </CardHeader>
              <CardContent>
                <Table>
                  <TableHeader>
                    <TableRow>
                      <TableHead>Name</TableHead>
                      <TableHead>Department</TableHead>
                      <TableHead>Class Level</TableHead>
                      <TableHead>GPA</TableHead>
                      <TableHead>Credits</TableHead>
                      <TableHead>Retention Rate</TableHead>
                      <TableHead>Avg Grade</TableHead>
                    </TableRow>
                  </TableHeader>
                  <TableBody>
                    {filteredStudents.map((student) => (
                      <TableRow key={student.id}>
                        <TableCell className="font-medium">{student.name}</TableCell>
                        <TableCell>{student.department}</TableCell>
                        <TableCell>{student.classLevel}</TableCell>
                        <TableCell className={getGradeColor(student.gpa * 25)}>{student.gpa}</TableCell>
                        <TableCell>{student.totalCredits}</TableCell>
                        <TableCell>{student.retentionRate}%</TableCell>
                        <TableCell className={getGradeColor(student.avgGrade)}>{student.avgGrade}%</TableCell>
                      </TableRow>
                    ))}
                  </TableBody>
                </Table>
              </CardContent>
            </Card>
          </TabsContent>

          {/* Enrollments Tab */}
          <TabsContent value="enrollments" className="space-y-6">
            <Card>
              <CardHeader>
                <CardTitle>Enrollment Records</CardTitle>
                <CardDescription>Detailed enrollment information and grades</CardDescription>
              </CardHeader>
              <CardContent>
                <Table>
                  <TableHeader>
                    <TableRow>
                      <TableHead>Student</TableHead>
                      <TableHead>Course</TableHead>
                      <TableHead>Semester</TableHead>
                      <TableHead>Grade</TableHead>
                      <TableHead>Letter</TableHead>
                      <TableHead>Credits</TableHead>
                      <TableHead>Status</TableHead>
                    </TableRow>
                  </TableHeader>
                  <TableBody>
                    {filteredEnrollments.map((enrollment) => (
                      <TableRow key={enrollment.id}>
                        <TableCell className="font-medium">{enrollment.studentName}</TableCell>
                        <TableCell>{enrollment.courseCode} - {enrollment.courseName}</TableCell>
                        <TableCell>{enrollment.semester}</TableCell>
                        <TableCell className={getGradeColor(enrollment.grade)}>{enrollment.grade}%</TableCell>
                        <TableCell>{enrollment.letterGrade}</TableCell>
                        <TableCell>{enrollment.credits}</TableCell>
                        <TableCell>
                          <Badge className={getStatusColor(enrollment.status)}>
                            {enrollment.status}
                          </Badge>
                        </TableCell>
                      </TableRow>
                    ))}
                  </TableBody>
                </Table>
              </CardContent>
            </Card>
          </TabsContent>
        </Tabs>
      </div>
    </div>
  )
} 