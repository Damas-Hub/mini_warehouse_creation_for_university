import Link from "next/link"
import { Button } from "@/components/ui/button"
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card"
import { Database, FileText, BarChart3 } from "lucide-react"

export default function HomePage() {
  return (
    <div className="min-h-screen bg-gray-50 p-6">
      <div className="max-w-4xl mx-auto space-y-8">
        {/* Header */}
        <div className="text-center space-y-4">
          <h1 className="text-4xl font-bold text-gray-900">University Data Warehouse Project</h1>
          <p className="text-xl text-gray-600">Course Registration System Analytics & Documentation</p>
        </div>

        {/* Navigation Cards */}
        <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
          <Card className="hover:shadow-lg transition-shadow">
            <CardHeader>
              <CardTitle className="flex items-center">
                <BarChart3 className="w-6 h-6 mr-2 text-blue-600" />
                Interactive Dashboard
              </CardTitle>
              <CardDescription>
                Explore the live data warehouse dashboard with analytics, data quality metrics, and data entry forms
              </CardDescription>
            </CardHeader>
            <CardContent>
              <Link href="/dashboard">
                <Button className="w-full">
                  <Database className="w-4 h-4 mr-2" />
                  View Dashboard
                </Button>
              </Link>
            </CardContent>
          </Card>

          <Card className="hover:shadow-lg transition-shadow">
            <CardHeader>
              <CardTitle className="flex items-center">
                <FileText className="w-6 h-6 mr-2 text-green-600" />
                Complete Documentation
              </CardTitle>
              <CardDescription>
                View detailed documentation with ER diagrams, star schema, SQL examples, and OLAP operations
              </CardDescription>
            </CardHeader>
            <CardContent>
              <Link href="/documentation">
                <Button variant="outline" className="w-full">
                  <FileText className="w-4 h-4 mr-2" />
                  View Documentation
                </Button>
              </Link>
            </CardContent>
          </Card>
        </div>

        {/* Project Overview */}
        <Card>
          <CardHeader>
            <CardTitle>Project Overview</CardTitle>
            <CardDescription>University Course Registration Data Warehouse Implementation</CardDescription>
          </CardHeader>
          <CardContent className="space-y-4">
            <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
              <div className="text-center p-4 bg-blue-50 rounded-lg">
                <div className="text-2xl font-bold text-blue-600">8</div>
                <p className="text-sm text-blue-800">Operational Tables</p>
              </div>
              <div className="text-center p-4 bg-green-50 rounded-lg">
                <div className="text-2xl font-bold text-green-600">7</div>
                <p className="text-sm text-green-800">Dimension Tables</p>
              </div>
              <div className="text-center p-4 bg-purple-50 rounded-lg">
                <div className="text-2xl font-bold text-purple-600">1</div>
                <p className="text-sm text-purple-800">Fact Table</p>
              </div>
            </div>

            <div className="space-y-2 text-sm">
              <h4 className="font-semibold">Key Features:</h4>
              <ul className="list-disc list-inside space-y-1 text-gray-600">
                <li>Complete star schema implementation with fact and dimension tables</li>
                <li>OLAP operations: Roll-up, Drill-down, Slice & Dice examples</li>
                <li>Interactive dashboard with real-time analytics</li>
                <li>Data quality monitoring and validation</li>
                <li>Manual data entry forms for testing</li>
                <li>Comprehensive SQL scripts for setup and queries</li>
              </ul>
            </div>
          </CardContent>
        </Card>
      </div>
    </div>
  )
}
