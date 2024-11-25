/*!--------------------------------------------------------
 * Copyright (C) Microsoft Corporation. All rights reserved.
 *--------------------------------------------------------*/var g=function(e,r){return g=Object.setPrototypeOf||{__proto__:[]}instanceof Array&&function(t,n){t.__proto__=n}||function(t,n){for(var i in n)Object.prototype.hasOwnProperty.call(n,i)&&(t[i]=n[i])},g(e,r)};export function __extends(e,r){if(typeof r!="function"&&r!==null)throw new TypeError("Class extends value "+String(r)+" is not a constructor or null");g(e,r);function t(){this.constructor=e}e.prototype=r===null?Object.create(r):(t.prototype=r.prototype,new t)}export var __assign=function(){return __assign=Object.assign||function(r){for(var t,n=1,i=arguments.length;n<i;n++){t=arguments[n];for(var o in t)Object.prototype.hasOwnProperty.call(t,o)&&(r[o]=t[o])}return r},__assign.apply(this,arguments)};export function __rest(e,r){var t={};for(var n in e)Object.prototype.hasOwnProperty.call(e,n)&&r.indexOf(n)<0&&(t[n]=e[n]);if(e!=null&&typeof Object.getOwnPropertySymbols=="function")for(var i=0,n=Object.getOwnPropertySymbols(e);i<n.length;i++)r.indexOf(n[i])<0&&Object.prototype.propertyIsEnumerable.call(e,n[i])&&(t[n[i]]=e[n[i]]);return t}export function __decorate(e,r,t,n){var i=arguments.length,o=i<3?r:n===null?n=Object.getOwnPropertyDescriptor(r,t):n,a;if(typeof Reflect=="object"&&typeof Reflect.decorate=="function")o=Reflect.decorate(e,r,t,n);else for(var u=e.length-1;u>=0;u--)(a=e[u])&&(o=(i<3?a(o):i>3?a(r,t,o):a(r,t))||o);return i>3&&o&&Object.defineProperty(r,t,o),o}export function __param(e,r){return function(t,n){r(t,n,e)}}export function __esDecorate(e,r,t,n,i,o){function a(m){if(m!==void 0&&typeof m!="function")throw new TypeError("Function expected");return m}for(var u=n.kind,f=u==="getter"?"get":u==="setter"?"set":"value",s=!r&&e?n.static?e:e.prototype:null,l=r||(s?Object.getOwnPropertyDescriptor(s,n.name):{}),p,_=!1,c=t.length-1;c>=0;c--){var d={};for(var y in n)d[y]=y==="access"?{}:n[y];for(var y in n.access)d.access[y]=n.access[y];d.addInitializer=function(m){if(_)throw new TypeError("Cannot add initializers after decoration has completed");o.push(a(m||null))};var h=(0,t[c])(u==="accessor"?{get:l.get,set:l.set}:l[f],d);if(u==="accessor"){if(h===void 0)continue;if(h===null||typeof h!="object")throw new TypeError("Object expected");(p=a(h.get))&&(l.get=p),(p=a(h.set))&&(l.set=p),(p=a(h.init))&&i.unshift(p)}else(p=a(h))&&(u==="field"?i.unshift(p):l[f]=p)}s&&Object.defineProperty(s,n.name,l),_=!0}export function __runInitializers(e,r,t){for(var n=arguments.length>2,i=0;i<r.length;i++)t=n?r[i].call(e,t):r[i].call(e);return n?t:void 0}export function __propKey(e){return typeof e=="symbol"?e:"".concat(e)}export function __setFunctionName(e,r,t){return typeof r=="symbol"&&(r=r.description?"[".concat(r.description,"]"):""),Object.defineProperty(e,"name",{configurable:!0,value:t?"".concat(t," ",r):r})}export function __metadata(e,r){if(typeof Reflect=="object"&&typeof Reflect.metadata=="function")return Reflect.metadata(e,r)}export function __awaiter(e,r,t,n){function i(o){return o instanceof t?o:new t(function(a){a(o)})}return new(t||(t=Promise))(function(o,a){function u(l){try{s(n.next(l))}catch(p){a(p)}}function f(l){try{s(n.throw(l))}catch(p){a(p)}}function s(l){l.done?o(l.value):i(l.value).then(u,f)}s((n=n.apply(e,r||[])).next())})}export function __generator(e,r){var t={label:0,sent:function(){if(o[0]&1)throw o[1];return o[1]},trys:[],ops:[]},n,i,o,a;return a={next:u(0),throw:u(1),return:u(2)},typeof Symbol=="function"&&(a[Symbol.iterator]=function(){return this}),a;function u(s){return function(l){return f([s,l])}}function f(s){if(n)throw new TypeError("Generator is already executing.");for(;a&&(a=0,s[0]&&(t=0)),t;)try{if(n=1,i&&(o=s[0]&2?i.return:s[0]?i.throw||((o=i.return)&&o.call(i),0):i.next)&&!(o=o.call(i,s[1])).done)return o;switch(i=0,o&&(s=[s[0]&2,o.value]),s[0]){case 0:case 1:o=s;break;case 4:return t.label++,{value:s[1],done:!1};case 5:t.label++,i=s[1],s=[0];continue;case 7:s=t.ops.pop(),t.trys.pop();continue;default:if(o=t.trys,!(o=o.length>0&&o[o.length-1])&&(s[0]===6||s[0]===2)){t=0;continue}if(s[0]===3&&(!o||s[1]>o[0]&&s[1]<o[3])){t.label=s[1];break}if(s[0]===6&&t.label<o[1]){t.label=o[1],o=s;break}if(o&&t.label<o[2]){t.label=o[2],t.ops.push(s);break}o[2]&&t.ops.pop(),t.trys.pop();continue}s=r.call(e,t)}catch(l){s=[6,l],i=0}finally{n=o=0}if(s[0]&5)throw s[1];return{value:s[0]?s[1]:void 0,done:!0}}}export var __createBinding=Object.create?function(e,r,t,n){n===void 0&&(n=t);var i=Object.getOwnPropertyDescriptor(r,t);(!i||("get"in i?!r.__esModule:i.writable||i.configurable))&&(i={enumerable:!0,get:function(){return r[t]}}),Object.defineProperty(e,n,i)}:function(e,r,t,n){n===void 0&&(n=t),e[n]=r[t]};export function __exportStar(e,r){for(var t in e)t!=="default"&&!Object.prototype.hasOwnProperty.call(r,t)&&__createBinding(r,e,t)}export function __values(e){var r=typeof Symbol=="function"&&Symbol.iterator,t=r&&e[r],n=0;if(t)return t.call(e);if(e&&typeof e.length=="number")return{next:function(){return e&&n>=e.length&&(e=void 0),{value:e&&e[n++],done:!e}}};throw new TypeError(r?"Object is not iterable.":"Symbol.iterator is not defined.")}export function __read(e,r){var t=typeof Symbol=="function"&&e[Symbol.iterator];if(!t)return e;var n=t.call(e),i,o=[],a;try{for(;(r===void 0||r-- >0)&&!(i=n.next()).done;)o.push(i.value)}catch(u){a={error:u}}finally{try{i&&!i.done&&(t=n.return)&&t.call(n)}finally{if(a)throw a.error}}return o}export function __spread(){for(var e=[],r=0;r<arguments.length;r++)e=e.concat(__read(arguments[r]));return e}export function __spreadArrays(){for(var e=0,r=0,t=arguments.length;r<t;r++)e+=arguments[r].length;for(var n=Array(e),i=0,r=0;r<t;r++)for(var o=arguments[r],a=0,u=o.length;a<u;a++,i++)n[i]=o[a];return n}export function __spreadArray(e,r,t){if(t||arguments.length===2)for(var n=0,i=r.length,o;n<i;n++)(o||!(n in r))&&(o||(o=Array.prototype.slice.call(r,0,n)),o[n]=r[n]);return e.concat(o||Array.prototype.slice.call(r))}export function __await(e){return this instanceof __await?(this.v=e,this):new __await(e)}export function __asyncGenerator(e,r,t){if(!Symbol.asyncIterator)throw new TypeError("Symbol.asyncIterator is not defined.");var n=t.apply(e,r||[]),i,o=[];return i={},u("next"),u("throw"),u("return",a),i[Symbol.asyncIterator]=function(){return this},i;function a(c){return function(d){return Promise.resolve(d).then(c,p)}}function u(c,d){n[c]&&(i[c]=function(y){return new Promise(function(h,m){o.push([c,y,h,m])>1||f(c,y)})},d&&(i[c]=d(i[c])))}function f(c,d){try{s(n[c](d))}catch(y){_(o[0][3],y)}}function s(c){c.value instanceof __await?Promise.resolve(c.value.v).then(l,p):_(o[0][2],c)}function l(c){f("next",c)}function p(c){f("throw",c)}function _(c,d){c(d),o.shift(),o.length&&f(o[0][0],o[0][1])}}export function __asyncDelegator(e){var r,t;return r={},n("next"),n("throw",function(i){throw i}),n("return"),r[Symbol.iterator]=function(){return this},r;function n(i,o){r[i]=e[i]?function(a){return(t=!t)?{value:__await(e[i](a)),done:!1}:o?o(a):a}:o}}export function __asyncValues(e){if(!Symbol.asyncIterator)throw new TypeError("Symbol.asyncIterator is not defined.");var r=e[Symbol.asyncIterator],t;return r?r.call(e):(e=typeof __values=="function"?__values(e):e[Symbol.iterator](),t={},n("next"),n("throw"),n("return"),t[Symbol.asyncIterator]=function(){return this},t);function n(o){t[o]=e[o]&&function(a){return new Promise(function(u,f){a=e[o](a),i(u,f,a.done,a.value)})}}function i(o,a,u,f){Promise.resolve(f).then(function(s){o({value:s,done:u})},a)}}export function __makeTemplateObject(e,r){return Object.defineProperty?Object.defineProperty(e,"raw",{value:r}):e.raw=r,e}var R=Object.create?function(e,r){Object.defineProperty(e,"default",{enumerable:!0,value:r})}:function(e,r){e.default=r};export function __importStar(e){if(e&&e.__esModule)return e;var r={};if(e!=null)for(var t in e)t!=="default"&&Object.prototype.hasOwnProperty.call(e,t)&&__createBinding(r,e,t);return R(r,e),r}export function __importDefault(e){return e&&e.__esModule?e:{default:e}}export function __classPrivateFieldGet(e,r,t,n){if(t==="a"&&!n)throw new TypeError("Private accessor was defined without a getter");if(typeof r=="function"?e!==r||!n:!r.has(e))throw new TypeError("Cannot read private member from an object whose class did not declare it");return t==="m"?n:t==="a"?n.call(e):n?n.value:r.get(e)}export function __classPrivateFieldSet(e,r,t,n,i){if(n==="m")throw new TypeError("Private method is not writable");if(n==="a"&&!i)throw new TypeError("Private accessor was defined without a setter");if(typeof r=="function"?e!==r||!i:!r.has(e))throw new TypeError("Cannot write private member to an object whose class did not declare it");return n==="a"?i.call(e,t):i?i.value=t:r.set(e,t),t}export function __classPrivateFieldIn(e,r){if(r===null||typeof r!="object"&&typeof r!="function")throw new TypeError("Cannot use 'in' operator on non-object");return typeof e=="function"?r===e:e.has(r)}export function __addDisposableResource(e,r,t){if(r!=null){if(typeof r!="object"&&typeof r!="function")throw new TypeError("Object expected.");var n,i;if(t){if(!Symbol.asyncDispose)throw new TypeError("Symbol.asyncDispose is not defined.");n=r[Symbol.asyncDispose]}if(n===void 0){if(!Symbol.dispose)throw new TypeError("Symbol.dispose is not defined.");n=r[Symbol.dispose],t&&(i=n)}if(typeof n!="function")throw new TypeError("Object not disposable.");i&&(n=function(){try{i.call(this)}catch(o){return Promise.reject(o)}}),e.stack.push({value:r,dispose:n,async:t})}else t&&e.stack.push({async:!0});return r}var C=typeof SuppressedError=="function"?SuppressedError:function(e,r,t){var n=new Error(t);return n.name="SuppressedError",n.error=e,n.suppressed=r,n};export function __disposeResources(e){function r(n){e.error=e.hasError?new C(n,e.error,"An error was suppressed during disposal."):n,e.hasError=!0}function t(){for(;e.stack.length;){var n=e.stack.pop();try{var i=n.dispose&&n.dispose.call(n.value);if(n.async)return Promise.resolve(i).then(t,function(o){return r(o),t()})}catch(o){r(o)}}if(e.hasError)throw e.error}return t()}export default{__extends,__assign,__rest,__decorate,__param,__metadata,__awaiter,__generator,__createBinding,__exportStar,__values,__read,__spread,__spreadArrays,__spreadArray,__await,__asyncGenerator,__asyncDelegator,__asyncValues,__makeTemplateObject,__importStar,__importDefault,__classPrivateFieldGet,__classPrivateFieldSet,__classPrivateFieldIn,__addDisposableResource,__disposeResources};function O(e){const r=[];typeof e=="number"&&r.push("code/timeOrigin",e);function t(i,o){r.push(i,o?.startTime??Date.now())}function n(){const i=[];for(let o=0;o<r.length;o+=2)i.push({name:r[o],startTime:r[o+1]});return i}return{mark:t,getMarks:n}}function x(){if(typeof performance=="object"&&typeof performance.mark=="function"&&!performance.nodeTiming)return typeof performance.timeOrigin!="number"&&!performance.timing?O():{mark(e,r){performance.mark(e,r)},getMarks(){let e=performance.timeOrigin;typeof e!="number"&&(e=performance.timing.navigationStart||performance.timing.redirectStart||performance.timing.fetchStart);const r=[{name:"code/timeOrigin",startTime:Math.round(e)}];for(const t of performance.getEntriesByType("mark"))r.push({name:t.name,startTime:Math.round(e+t.startTime)});return r}};if(typeof process=="object"){const e=performance?.timeOrigin;return O(e)}else return console.trace("perf-util loaded in UNKNOWN environment"),O()}function j(e){return e.MonacoPerformanceMarks||(e.MonacoPerformanceMarks=x()),e.MonacoPerformanceMarks}var P=j(globalThis),S=P.mark,re=P.getMarks;import*as T from"path";import"fs";import{fileURLToPath as I}from"url";import{createRequire as A}from"node:module";var N=A(import.meta.url),ie=T.dirname(I(import.meta.url));if(Error.stackTraceLimit=100,!process.env.VSCODE_HANDLES_SIGPIPE){let e=!1;process.on("SIGPIPE",()=>{e||(e=!0,console.error(new Error("Unexpected SIGPIPE")))})}function L(){try{typeof process.env.VSCODE_CWD!="string"&&(process.env.VSCODE_CWD=process.cwd()),process.platform==="win32"&&process.chdir(T.dirname(process.execPath))}catch(e){console.error(e)}}L();function M(e){if(!process.env.VSCODE_DEV)return;if(!e)throw new Error("Missing injectPath");N("node:module").register("./bootstrap-import.js",{parentURL:import.meta.url,data:e})}function G(){if(typeof process?.versions?.electron=="string")return;const e=N("module"),r=e.globalPaths,t=e._resolveLookupPaths;e._resolveLookupPaths=function(n,i){const o=t(n,i);if(Array.isArray(o)){let a=0;for(;a<o.length&&o[o.length-1-a]===r[r.length-1-a];)a++;return o.slice(0,o.length-a)}return o}}import*as U from"path";import*as E from"fs";import{fileURLToPath as F}from"url";import{createRequire as V,register as k}from"node:module";import{createRequire as $}from"node:module";var D=$(import.meta.url),b={BUILD_INSERT_PRODUCT_CONFIGURATION:"BUILD_INSERT_PRODUCT_CONFIGURATION"};b.BUILD_INSERT_PRODUCT_CONFIGURATION&&(b=D("../product.json"));var w={"name":"Code","version":"1.95.3","private":true,"overrides":{"node-gyp-build":"4.8.1","kerberos@2.1.1":{"node-addon-api":"7.1.0"},"@parcel/watcher@2.1.0":{"node-addon-api":"7.1.0"}},"type":"module"};w.BUILD_INSERT_PACKAGE_CONFIGURATION&&(w=D("../package.json"));var B=b,H=w,J=V(import.meta.url),q=U.dirname(F(import.meta.url));if((process.env.ELECTRON_RUN_AS_NODE||process.versions.electron)&&k(`data:text/javascript;base64,${Buffer.from(`
	export async function resolve(specifier, context, nextResolve) {
		if (specifier === 'fs') {
			return {
				format: 'builtin',
				shortCircuit: true,
				url: 'node:original-fs'
			};
		}

		// Defer to the next hook in the chain, which would be the
		// Node.js default resolve if this is the last user-specified loader.
		return nextResolve(specifier, context);
	}`).toString("base64")}`,import.meta.url),globalThis._VSCODE_PRODUCT_JSON={...B},process.env.VSCODE_DEV)try{const e=J("../product.overrides.json");globalThis._VSCODE_PRODUCT_JSON=Object.assign(globalThis._VSCODE_PRODUCT_JSON,e)}catch{}globalThis._VSCODE_PACKAGE_JSON={...H},globalThis._VSCODE_FILE_ROOT=q;var v=void 0;function K(){return v||(v=W()),v}async function W(){S("code/willLoadNls");let e,r;if(process.env.VSCODE_NLS_CONFIG)try{e=JSON.parse(process.env.VSCODE_NLS_CONFIG),e?.languagePack?.messagesFile?r=e.languagePack.messagesFile:e?.defaultMessagesFile&&(r=e.defaultMessagesFile),globalThis._VSCODE_NLS_LANGUAGE=e?.resolvedLanguage}catch(t){console.error(`Error reading VSCODE_NLS_CONFIG from environment: ${t}`)}if(!(process.env.VSCODE_DEV||!r)){try{globalThis._VSCODE_NLS_MESSAGES=JSON.parse((await E.promises.readFile(r)).toString())}catch(t){if(console.error(`Error reading NLS messages file ${r}: ${t}`),e?.languagePack?.corruptMarkerFile)try{await E.promises.writeFile(e.languagePack.corruptMarkerFile,"corrupted")}catch(n){console.error(`Error writing corrupted NLS marker file: ${n}`)}if(e?.defaultMessagesFile&&e.defaultMessagesFile!==r)try{globalThis._VSCODE_NLS_MESSAGES=JSON.parse((await E.promises.readFile(e.defaultMessagesFile)).toString())}catch(n){console.error(`Error reading default NLS messages file ${e.defaultMessagesFile}: ${n}`)}}return S("code/didLoadNls"),e}}async function X(){await K()}S("code/fork/start");function Y(){function t(f){const s=[],l=[];if(f.length)for(let p=0;p<f.length;p++){let _=f[p];if(typeof _>"u")_="undefined";else if(_ instanceof Error){const c=_;c.stack?_=c.stack:_=c.toString()}l.push(_)}try{const p=JSON.stringify(l,function(_,c){if(i(c)||Array.isArray(c)){if(s.indexOf(c)!==-1)return"[Circular]";s.push(c)}return c});return p.length>1e5?"Output omitted for a large object that exceeds the limits":p}catch(p){return`Output omitted for an object that cannot be inspected ('${p.toString()}')`}}function n(f){try{process.send&&process.send(f)}catch{}}function i(f){return typeof f=="object"&&f!==null&&!Array.isArray(f)&&!(f instanceof RegExp)&&!(f instanceof Date)}function o(f,s){n({type:"__$console",severity:f,arguments:s})}function a(f,s){Object.defineProperty(console,f,{set:()=>{},get:()=>function(){o(s,t(arguments))}})}function u(f,s){const l=process[f],p=l.write;let _="";Object.defineProperty(l,"write",{set:()=>{},get:()=>(c,d,y)=>{_+=c.toString(d);const h=_.length>1048576?_.length:_.lastIndexOf(`
`);h!==-1&&(console[s](_.slice(0,h)),_=_.slice(h+1)),p.call(l,c,d,y)}})}process.env.VSCODE_VERBOSE_LOGGING==="true"?(a("info","log"),a("log","log"),a("warn","warn"),a("error","error")):(console.log=function(){},console.warn=function(){},console.info=function(){},a("error","error")),u("stderr","error"),u("stdout","log")}function Q(){process.on("uncaughtException",function(e){console.error("Uncaught Exception: ",e)}),process.on("unhandledRejection",function(e){console.error("Unhandled Promise Rejection: ",e)})}function z(){const e=Number(process.env.VSCODE_PARENT_PID);typeof e=="number"&&!isNaN(e)&&setInterval(function(){try{process.kill(e,0)}catch{process.exit()}},5e3)}function Z(){const e=process.env.VSCODE_CRASH_REPORTER_PROCESS_TYPE;if(e)try{process.crashReporter&&typeof process.crashReporter.addExtraParameter=="function"&&process.crashReporter.addExtraParameter("processType",e)}catch(r){console.error(r)}}Z(),G(),process.env.VSCODE_DEV_INJECT_NODE_MODULE_LOOKUP_PATH&&M(process.env.VSCODE_DEV_INJECT_NODE_MODULE_LOOKUP_PATH),process.send&&process.env.VSCODE_PIPE_LOGGING==="true"&&Y(),process.env.VSCODE_HANDLES_UNCAUGHT_ERRORS||Q(),process.env.VSCODE_PARENT_PID&&z(),await X(),await import([`./${process.env.VSCODE_ESM_ENTRYPOINT}.js`].join("/"));

//# sourceMappingURL=https://main.vscode-cdn.net/sourcemaps/f1a4fb101478ce6ec82fe9627c43efbf9e98c813/core/bootstrap-fork.js.map
