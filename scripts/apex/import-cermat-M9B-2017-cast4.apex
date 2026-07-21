String SRC   = 'CERMAT – Jednotná přijímací zkouška 2017, 2. řádný termín (M9B)';
String STYPE = 'CERMAT';

public class C {
  Map<String,Id> tx; Set<String> have; String src; String stype; public Integer created=0;
  C(Map<String,Id> tx, Set<String> have, String src, String stype){this.tx=tx;this.have=have;this.src=src;this.stype=stype;}
  Id sv(String t,String fn,String s){ContentVersion cv=new ContentVersion(Title=t,PathOnClient=fn,VersionData=Blob.valueOf(s),Origin='H');insert cv;return [SELECT ContentDocumentId FROM ContentVersion WHERE Id=:cv.Id].ContentDocumentId;}
  void lk(Id d,Id r){try{insert new ContentDocumentLink(ContentDocumentId=d,LinkedEntityId=r,ShareType='V',Visibility='AllUsers');}catch(Exception e){insert new ContentDocumentLink(ContentDocumentId=d,LinkedEntityId=r,ShareType='V',Visibility='InternalUsers');}}
  String para(String t){return '{"type":"paragraph","text":'+JSON.serialize(t)+'}';}
  String content(List<String> zad, Id d, String alt, String cap, List<String> opts, Integer ln){
    String s='{"schemaVersion":1,"blocks":[';
    for(Integer i=0;i<zad.size();i++){if(i>0)s+=',';s+=para(zad[i]);}
    if(d!=null){s+=',{"type":"image","contentDocumentId":"'+d+'","alt":'+JSON.serialize(alt)+',"caption":'+JSON.serialize(cap)+',"widthPercent":75,"align":"center"}';}
    if(opts!=null && !opts.isEmpty()){s+=',{"type":"list","items":[';for(Integer i=0;i<opts.size();i++){if(i>0)s+=',';s+=JSON.serialize(opts[i]);}s+=']}';}
    if(ln!=null && ln>0){s+=',{"type":"answerSpace","lines":'+ln+'}';}
    s+=']}';return s;
  }
  String solution(List<String> ps){String s='{"schemaVersion":1,"blocks":[';for(Integer i=0;i<ps.size();i++){if(i>0)s+=',';s+=para(ps[i]);}s+=']}';return s;}
  void add(String name,List<String> zad,List<String> opts,Integer ln,String svg,String fn,String alt,String cap,List<String> solp,String ans,Decimal pts,Decimal mins,String diff,List<String> codes,String ccode,Integer yr){
    if(have.contains(name))return;
    Id d=(svg!=null)?sv(name,fn,svg):null;
    Math_Problem__c mp=new Math_Problem__c(Name=name,Status__c='Publikováno',Visibility__c='Organizace',Language__c='cs',Current_Version_Number__c=1);insert mp;
    String cj=content(zad,d,alt,cap,opts,ln); String sj=solution(solp);
    String aj=JSON.serialize(new Map<String,Object>{'type'=>'Text','value'=>ans});
    Problem_Version__c pub=new Problem_Version__c(Problem__c=mp.Id,Version_Number__c=1,Is_Published__c=true,Published_At__c=Datetime.now(),Title__c=name,Content_JSON__c=cj,Solution_JSON__c=sj,Answer_JSON__c=aj,Answer_Type__c='Text',Points__c=pts,Expected_Time_Min__c=mins,Difficulty__c=diff,Source__c=src,Source_Type__c=stype,License__c='Jiná',CERMAT_Code__c=ccode,Source_Year__c=yr,Search_Text__c=GoMathContent.buildSearchText(name,cj,sj,null));
    insert pub;
    List<Problem_Taxon__c> ls=new List<Problem_Taxon__c>();
    for(String code:codes){Id ti=tx.get(code);if(ti==null)continue;ls.add(new Problem_Taxon__c(Problem_Version__c=pub.Id,Taxon__c=ti,Unique_Key__c=pub.Id+'_'+ti));}
    if(!ls.isEmpty())insert ls;
    if(d!=null)lk(d,mp.Id);
    created++;
  }
}
Map<String,Id> tx=new Map<String,Id>();
for(Taxon__c t:[SELECT Id,Code__c FROM Taxon__c])tx.put(t.Code__c,t.Id);
Set<String> have=new Set<String>();
for(Math_Problem__c p:[SELECT Name FROM Math_Problem__c])have.add(p.Name);
C c=new C(tx,have,SRC,STYPE);

c.add(
  'CERMAT 2017 M9B · úloha 10',
  new List<String>{'Kružnici $k$ se středem $S$ protíná přímka ve dvou bodech $C$ a $D$ (viz obrázek).','Body $C$, $D$ jsou vrcholy rovnoramenného lichoběžníku $ABCD$. Všechny čtyři vrcholy tohoto lichoběžníku leží na kružnici $k$. Vzdálenost chybějících vrcholů $A$, $B$ od přímky $CD$ je rovna poloměru $r=|SC|$ kružnice $k$.','10.1 Sestrojte vrcholy $A$, $B$ lichoběžníku $ABCD$ a lichoběžník narýsujte.','10.2 Sestrojte osu souměrnosti lichoběžníku $ABCD$ (pokud existuje) a označte ji $o$.','10.3 Sestrojte výšku lichoběžníku $ABCD$ z vrcholu $D$ a označte ji $v$.'},
  null,
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 312 273"><path d="M186 147L191 153L190 154L185 148Z" style="fill:#000000"/><path d="M186 153L191 148L190 147L185 152Z" style="fill:#000000"/><path d="M68 149L67 149L67 146L67 143L67 140L68 137L68 134L68 131L69 128L69 125L70 122L71 119L72 117L72 114L73 111L74 108L75 106L76 103L78 100L79 97L80 95L82 92L83 90L84 87L86 85L88 82L89 80L91 78L93 75L94 73L96 71L98 69L100 67L102 65L104 63L106 61L109 59L111 57L113 55L115 53L118 52L120 50L122 48L125 47L127 45L130 44L133 43L135 41L138 40L141 39L143 38L146 37L149 36L152 35L154 34L157 33L160 33L163 32L166 31L169 31L172 30L175 30L178 30L181 30L184 30L187 29L190 30L194 30L197 30L200 30L203 30L206 31L209 31L212 32L215 33L217 33L220 34L223 35L226 36L229 37L232 38L234 39L237 40L240 41L242 43L245 44L247 45L250 47L252 48L255 50L257 52L259 53L262 55L264 57L266 59L268 61L270 63L272 65L274 67L277 69L278 71L280 73L282 75L284 78L286 80L287 82L289 85L290 87L292 90L293 92L295 95L296 97L297 100L298 103L299 105L300 108L301 111L302 114L303 117L304 119L305 122L305 125L306 128L306 131L307 134L307 137L307 140L308 143L308 146L308 153L308 156L307 159L307 162L307 165L306 168L306 171L305 174L305 177L304 179L303 182L302 185L301 188L300 191L299 193L298 196L297 199L296 202L295 204L293 207L292 209L290 212L289 214L287 217L286 219L284 221L282 224L280 226L278 228L277 230L274 232L272 234L270 236L268 238L266 240L264 242L262 244L259 246L257 247L255 249L252 251L250 252L247 254L245 255L242 256L240 258L237 259L234 260L232 261L229 262L226 263L223 264L220 265L217 266L215 266L212 267L209 268L206 268L203 268L200 269L197 269L194 269L190 269L184 269L181 269L178 269L175 269L172 268L169 268L166 268L163 267L160 266L157 266L154 265L152 264L149 263L146 262L143 261L141 260L138 259L135 258L133 256L130 255L127 254L125 252L122 251L120 249L118 247L115 246L113 244L111 242L109 240L106 238L104 236L102 234L100 232L98 230L96 228L94 226L93 224L91 221L89 219L88 217L86 214L84 212L83 209L82 207L80 204L79 202L78 199L76 196L75 193L74 191L73 188L72 185L72 182L71 179L70 177L69 174L69 171L68 168L68 165L68 162L67 159L67 156L67 153L67 148L68 149M67 150L68 149L69 153L69 152L69 156L69 159L69 162L69 165L70 168L70 167L70 170L71 173L72 176L72 179L73 182L73 182L74 185L75 187L76 190L76 190L77 193L78 196L78 196L79 198L79 198L80 201L82 203L83 206L84 208L86 211L87 213L87 213L89 216L90 218L92 220L94 223L96 225L97 227L97 227L99 229L101 231L103 233L103 233L105 235L107 237L110 239L112 241L114 243L114 243L116 244L119 246L121 248L123 249L126 251L126 251L128 252L131 254L133 255L136 256L139 258L138 257L141 259L141 259L144 260L147 261L146 261L149 262L149 262L152 263L152 263L155 263L158 264L158 264L160 265L160 265L163 266L163 266L166 266L169 267L172 267L175 267L178 268L181 268L184 268L184 268L187 268L190 268L193 268L196 268L199 267L202 267L205 267L208 266L208 266L211 266L214 265L217 264L220 263L223 263L226 262L228 261L231 260L234 259L236 257L236 258L239 256L241 255L244 254L244 254L247 252L249 251L251 249L254 248L256 246L259 244L261 243L263 241L265 239L267 237L269 235L271 233L271 233L273 231L275 229L277 227L277 227L279 225L281 223L281 223L283 220L284 218L286 216L288 213L288 213L289 211L291 208L290 208L292 206L293 203L295 201L296 198L297 196L298 193L299 190L300 187L301 185L302 182L303 179L303 176L304 173L304 170L305 168L305 165L306 162L306 159L306 156L306 153L306 149L306 146L306 146L306 143L306 140L306 137L305 134L305 131L304 128L304 126L303 123L302 120L302 117L301 114L301 114L300 111L299 109L299 109L298 106L297 103L296 101L295 98L293 96L292 93L292 93L290 91L291 91L289 88L288 86L286 83L286 83L284 81L283 79L281 76L279 74L279 74L277 72L275 70L273 68L271 66L269 64L267 62L265 60L263 58L261 56L259 55L256 53L254 51L251 50L249 48L247 47L244 45L241 44L239 43L236 41L234 40L231 39L228 38L226 37L223 36L220 35L217 35L214 34L211 33L208 33L208 33L205 32L202 32L199 32L200 32L196 31L193 31L190 31L187 31L184 31L184 31L181 31L178 31L175 32L172 32L169 32L166 33L163 33L163 33L160 34L158 35L158 35L155 35L152 36L152 36L149 37L146 38L147 38L144 39L141 40L141 40L138 41L139 41L136 43L133 44L131 45L128 47L126 48L126 48L123 50L121 51L119 53L116 55L114 56L114 56L112 58L110 60L107 62L105 64L103 66L101 68L99 70L97 72L96 74L94 76L92 79L92 79L90 81L89 83L87 86L86 88L84 91L83 93L83 93L82 96L80 98L79 101L78 103L77 106L76 109L75 112L74 114L73 117L72 120L72 120L72 123L71 126L70 129L70 128L70 131L69 134L69 134L69 137L69 140L69 143L69 143L69 146L68 151Z" style="fill:#000000"/><path d="M5 139L231 5L230 4L4 137Z" style="fill:#000000"/><path d="M189 152L189 30L187 30L187 152Z" style="fill:#000000"/><text x="186" y="27" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">C</text><text x="279" y="62" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">k</text><text x="198" y="163" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">S</text><text x="76" y="92" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">D</text></svg>',
  'obr.svg',
  'Kružnice k se středem S; přímka protíná kružnici v bodech C a D, vyznačena je úsečka SC (poloměr r).',
  '',
  new List<String>{'Vrcholy $A$, $B$ leží na kružnici $k$ a jejich vzdálenost od přímky $CD$ je $r$. Sestrojíme rovnoběžku s $CD$ ve vzdálenosti $r$ (na té straně, kde vznikne lichoběžník) a její průsečíky s kružnicí $k$ jsou hledané body $A$ a $B$. Vrcholy spojíme do rovnoramenného lichoběžníku $ABCD$ se základnami $AB\\parallel CD$.','Osa souměrnosti $o$ rovnoramenného lichoběžníku je osa obou základen (prochází středem $S$ kolmo k $CD$ i $AB$). Výška $v$ z vrcholu $D$ je kolmice vedená z bodu $D$ k základně $AB$.','Jde o konstrukční úlohu; hodnotí se přesnost a úplnost konstrukce.'},
  'Konstrukce rovnoramenného lichoběžníku $ABCD$ vepsaného do $k$ ($A$, $B$ na $k$ ve vzdálenosti $r$ od $CD$), osa souměrnosti $o$ (osa základen procházející $S$) a výška $v$ z vrcholu $D$.',
  3, 6, '4',
  new List<String>{'zs2','r9','konstrukce','planimetrie','geometrie','rysovani','soumernost','bez-kontextu'},
  'M9PBD17C0T02', 2017
);

System.debug('Vytvořeno úloh: '+c.created);
