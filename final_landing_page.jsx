import React from "react";
import { motion } from "framer-motion";
import { Button } from "@/components/ui/button";
import { Card, CardContent } from "@/components/ui/card";
import { ArrowRight, CheckCircle, Sparkles } from "lucide-react";

export default function FinalLandingPage() {
  return (
    <div className="min-h-screen w-full bg-gradient-to-br from-gray-900 via-black to-gray-900 text-white">
      {/* HERO SECTION */}
      <div className="flex flex-col items-center text-center px-6 py-24">
        <motion.h1
          initial={{ opacity: 0, y: -20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.6 }}
          className="text-5xl md:text-6xl font-bold tracking-tight"
        >
          The Future of Smart Solutions
        </motion.h1>

        <motion.p
          initial={{ opacity: 0 }}
          animate={{ opacity: 1 }}
          transition={{ delay: 0.4, duration: 0.6 }}
          className="mt-4 text-lg md:text-xl max-w-2xl text-gray-300"
        >
          Powerful. Minimal. Intelligent. Built with precision and crafted for real performance.
        </motion.p>

        <motion.div
          initial={{ opacity: 0 }}
          animate={{ opacity: 1 }}
          transition={{ delay: 0.7 }}
          className="mt-8 flex gap-4"
        >
          <Button className="rounded-2xl text-lg px-6 py-6 shadow-xl hover:scale-105 transition">
            Get Started <ArrowRight className="ml-2 h-5 w-5" />
          </Button>

          <Button
            variant="outline"
            className="rounded-2xl text-lg px-6 py-6 border-gray-500 hover:bg-white hover:text-black transition shadow-md"
          >
            Learn More
          </Button>
        </motion.div>
      </div>

      {/* FEATURES */}
      <div className="px-6 py-20 max-w-6xl mx-auto grid md:grid-cols-3 gap-8">
        {["High Performance", "Premium UI/UX", "Future Ready"]?.map((title, idx) => (
          <motion.div
            key={idx}
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ delay: idx * 0.3, duration: 0.6 }}
          >
            <Card className="bg-white/5 border-white/10 backdrop-blur-xl rounded-2xl shadow-2xl hover:scale-[1.03] transition cursor-pointer">
              <CardContent className="p-8 flex flex-col items-center text-center">
                <Sparkles className="h-10 w-10 text-purple-400" />
                <h3 className="mt-5 text-2xl font-semibold">{title}</h3>
                <p className="mt-3 text-gray-300 text-sm">
                  Lorem ipsum dolor sit amet consectetur adipisicing elit. Tempore, fuga.
                </p>
              </CardContent>
            </Card>
          </motion.div>
        ))}
      </div>

      {/* PRICING */}
      <div className="py-20 bg-black/30 backdrop-blur-xl px-6">
        <h2 className="text-4xl font-bold text-center">Simple Pricing</h2>
        <p className="text-center text-gray-400 mt-2">Choose the plan that fits you best</p>

        <div className="max-w-4xl mx-auto grid md:grid-cols-3 gap-8 mt-12">
          {["Starter", "Professional", "Enterprise"].map((plan, idx) => (
            <motion.div
              key={idx}
              initial={{ opacity: 0, y: 20 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ delay: 0.2 * idx }}
            >
              <Card className="bg-white/5 border-white/10 backdrop-blur-xl rounded-2xl shadow-2xl hover:scale-[1.02] transition cursor-pointer">
                <CardContent className="p-8">
                  <h3 className="text-2xl font-semibold text-center">{plan}</h3>
                  <p className="text-center text-gray-300 mt-2">Perfect for {plan} usage</p>

                  <div className="mt-6 flex justify-center text-4xl font-bold">
                    ₹{(idx + 1) * 499}
                  </div>

                  <ul className="mt-6 space-y-3 text-gray-300">
                    <li className="flex items-center gap-2">
                      <CheckCircle className="h-5 w-5 text-green-400" /> Feature One
                    </li>
                    <li className="flex items-center gap-2">
                      <CheckCircle className="h-5 w-5 text-green-400" /> Feature Two
                    </li>
                    <li className="flex items-center gap-2">
                      <CheckCircle className="h-5 w-5 text-green-400" /> Feature Three
                    </li>
                  </ul>

                  <Button className="mt-8 w-full rounded-xl py-6 text-lg">Choose Plan</Button>
                </CardContent>
              </Card>
            </motion.div>
          ))}
        </div>
      </div>

      {/* FOOTER */}
      <footer className="py-10 text-center text-gray-400 text-sm">
        © {new Date().getFullYear()} Smart Solutions. All rights reserved.
      </footer>
    </div>
  );
}
