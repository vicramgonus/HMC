clingo.init("https://cdn.jsdelivr.net/npm/clingo-wasm@0.0.10/dist/clingo.wasm")


function createClingoCode(ident){
   var preEl = document.createElement('div');
   preEl.className = "clingo-code";
   preEl.id = ident + "-input";
   
   preEl.innerHTML = clingoExamples[ident].replaceAll("\n", "<br>");
   
   var divRef = document.getElementById(ident);
   divRef.appendChild(preEl);
}

function createClingoQuery(ident, includes, models=1, constants="", quiet=false){
   var preEl = document.createElement('div');
   preEl.className = "clingo-code2";

   var divRef = document.getElementById(`${ident}`);

   
   var butEl = document.createElement('button');
   butEl.innerHTML = "> " + `clingo ${ident.split("-")[0]}.lp ${models} ${constants} ${quiet ? "--quiet" : ""}`;
   butEl.className = "clingo-query";
   butEl.setAttribute("onClick", `runClingoChunk('${ident}', [${includes.map(i => "\"" + i + "\"").join(",")}], ${models}, '${constants}', ${quiet})`); 
   
   divRef.appendChild(preEl);
   preEl.appendChild(butEl);


}

async function runClingoChunk(ident, includes, models, constants, quiet){
   console.log(includes);
   var button = document.querySelector("#"+ident+" button");
   button.disabled = true;
   button.innerHTML = 'PROCESSING...';

   var ident2 = ident.split("-")[0];
   var content = clingoExamples[ident2] + includes.map(i => clingoExamples[i]).join("\n\n");

   console.log(content);
   var constArray = constants.split("-c").filter(x => x.trim() != "").map(x => x.split("=").map(y=> y.trim()));
   for (var c of constArray){
      console.log(c);
      content = content.replaceAll(`#const ${c[0]}=`, `#const ${c[0]}=${c[1]}. %`);
   }
   console.log(content);
  
   var result = await clingo.run(content, models);

   button.remove();

   console.log(result);


   var divEl = document.createElement('div');
   divEl.className = result.Result === 'ERROR' ? "clingo-response-error" : "clingo-response-correct";
   
   responseText = 'The program is ';
   
   if (result.Result === 'ERROR') {
      divEl.classList.add('output-error');
      responseText +=  `errored:
<span>\`${result.Error}\`.`;
   } else {
      divEl.classList.add('output-success');
      responseText +=  `${result.Result}`;

      if (result.Models.Number > 0){
         responseText +=  ` and ${result.Models.Number} models has been obtained.`;
         
         if (!quiet){
            responseText += `The models are: <ul>${
               result.Call[0].Witnesses.map(
               w => `<li> { ${w.Value.length ? w.Value.map(v => `${v}`).join(', ') : ` `} } ${w.Costs ? ` ( - Costs: ${w.Costs})` : ''}</li>`
               ).join('\n')
               }</ul>`;
         }else{
            responseText += `\n\n`;
         }
      } else {
   responseText += `.\n`;
}
responseText += `We got this result from ${result.Solver} in ${result.Time.Total}s (solving time was ${result.Time.Solve}s).`
}



   divEl.innerHTML = responseText;

   document.getElementById(ident).appendChild(divEl);

}

function download(ident, text) {
   var element = document.createElement('a');
   element.setAttribute('href', 'data:text/plain;charset=utf-8,' + encodeURIComponent(text));
   element.setAttribute('download', ident);

   element.style.display = 'none';
   document.body.appendChild(element);

   element.click();

   document.body.removeChild(element);
}