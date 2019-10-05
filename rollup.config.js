import resolve from 'rollup-plugin-node-resolve';
import commonjs from 'rollup-plugin-commonjs';
import { terser } from 'rollup-plugin-terser';
import minify from 'rollup-plugin-babel-minify';
import typescript from 'rollup-plugin-typescript';

// `npm run build` -> `production` is true
// `npm run dev` -> `production` is false
const production = !process.env.ROLLUP_WATCH;

export default [
	{
		input: 'src/js/chain.ts',
		output: {
			name: "chain",
			file: 'public/js/chain.js',
			format: 'iife', // immediately-invoked function expression — suitable for <script> tags
			sourcemap: true,
			globals: {
				"d3": "d3"
			}
		},
		plugins: [
			resolve(), // tells Rollup how to find date-fns in node_modules
			commonjs(), // converts date-fns to ES modules
			minify(),
			typescript(),
			production && terser() // minify, but only in production
		]
	},
	{
		input: 'src/js/tabs.ts',
		output: {
			name: "tabs",
			file: 'public/js/tabs.js',
			format: 'iife', // immediately-invoked function expression — suitable for <script> tags
			sourcemap: true
		},
		plugins: [
			resolve(), // tells Rollup how to find date-fns in node_modules
			commonjs(), // converts date-fns to ES modules
			minify(),
			typescript(),
			production && terser() // minify, but only in production
		]
	},
	{
		input: 'src/js/popchart.ts',
		output: {
			name: "popchart",
			file: 'public/js/popchart.js',
			format: 'iife', // immediately-invoked function expression — suitable for <script> tags
			sourcemap: true
		},
		plugins: [
			resolve(), // tells Rollup how to find date-fns in node_modules
			commonjs(), // converts date-fns to ES modules
			minify(),
			typescript(),
			production && terser() // minify, but only in production
		]
	}
]
