String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PAD17C0T01';
Integer YEAR = 2017;

public class C {
  Map<String,Id> tx; Set<String> have; String src; String stype; String ccode; Integer yr; public Integer created=0;
  C(Map<String,Id> tx, Set<String> have, String src, String stype, String ccode, Integer yr){this.tx=tx;this.have=have;this.src=src;this.stype=stype;this.ccode=ccode;this.yr=yr;}
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
  void add(String name,List<String> zad,List<String> opts,Integer ln,String svg,String fn,String alt,String cap,List<String> solp,String ans,Decimal pts,Decimal mins,String diff,List<String> codes){
    if(have.contains(name))return;
    Id d=(svg!=null)?sv(name,fn,svg):null;
    Math_Problem__c mp=new Math_Problem__c(Name=name,Status__c='Publikováno',Visibility__c='Organizace',Language__c='cs',Current_Version_Number__c=1);insert mp;
    String cj=content(zad,d,alt,cap,opts,ln); String sj=solution(solp);
    String aj=JSON.serialize(new Map<String,Object>{'type'=>'Text','value'=>ans});
    Problem_Version__c pub=new Problem_Version__c(Problem__c=mp.Id,Version_Number__c=1,Is_Published__c=true,Published_At__c=Datetime.now(),Title__c=name,Content_JSON__c=cj,Solution_JSON__c=sj,Answer_JSON__c=aj,Answer_Type__c='Text',Points__c=pts,Expected_Time_Min__c=mins,Difficulty__c=diff,Source__c=src,Source_Type__c=stype,CERMAT_Code__c=ccode,Source_Year__c=yr,License__c='Jiná',Search_Text__c=GoMathContent.buildSearchText(name,cj,sj,null));
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
C c=new C(tx,have,SRC,STYPE,CCODE,YEAR);

c.add(
  'CERMAT M7A 2017 – úloha 12',
  new List<String>{'Obrazec se skládá z trojúhelníku a obdélníku. Obrazec je osově souměrný podle osy souměrnosti $o$. Celková výška obrazce je $9$ cm, výška obdélníku je $5$ cm, vzdálenost osy $o$ od boční strany obdélníku je $1{,}5$ cm a vzdálenost boční strany obdélníku od krajního vrcholu trojúhelníku je $4$ cm.','Jaký je obsah obrazce?'},
  new List<String>{'A) $37$ cm²','B) $38$ cm²','C) $39$ cm²','D) $40$ cm²','E) větší než $40$ cm²'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 330" font-family="sans-serif"> <polygon points="240,36 383,140 97,140" fill="#b5b5b5" stroke="#000" stroke-width="2.5"/> <rect x="201" y="140" width="78" height="130" fill="#b5b5b5" stroke="#000" stroke-width="2.5"/> <line x1="240" y1="20" x2="240" y2="308" stroke="#000" stroke-width="1.5" stroke-dasharray="14 5 3 5"/> <text x="228" y="18" font-size="15" font-style="italic">o</text> <line x1="240" y1="36" x2="470" y2="36" stroke="#000" stroke-width="1"/> <line x1="97" y1="270" x2="470" y2="270" stroke="#000" stroke-width="1"/> <line x1="440" y1="36" x2="440" y2="270" stroke="#000" stroke-width="1.5"/> <polygon points="440,36 435,50 445,50" fill="#000"/><polygon points="440,270 435,256 445,256" fill="#000"/> <text x="456" y="160" font-size="16">9 cm</text> <line x1="70" y1="140" x2="70" y2="270" stroke="#000" stroke-width="1.5"/> <polygon points="70,140 65,154 75,154" fill="#000"/><polygon points="70,270 65,256 75,256" fill="#000"/> <line x1="70" y1="140" x2="97" y2="140" stroke="#000" stroke-width="1"/> <text x="14" y="212" font-size="16">5 cm</text> <line x1="279" y1="168" x2="383" y2="168" stroke="#000" stroke-width="1.5"/> <polygon points="279,168 293,163 293,173" fill="#000"/><polygon points="383,168 369,163 369,173" fill="#000"/> <text x="300" y="192" font-size="16">4 cm</text> <line x1="201" y1="296" x2="240" y2="296" stroke="#000" stroke-width="1.5"/> <polygon points="201,296 215,291 215,301" fill="#000"/><polygon points="240,296 226,291 226,301" fill="#000"/> <text x="180" y="322" font-size="16">1,5 cm</text> </svg>',
  'obrazec-osa.svg',
  'Osově souměrný obrazec: trojúhelník nahoře a obdélník dole, s kótami 9 cm, 5 cm, 4 cm a 1,5 cm.',
  'Výchozí obrázek k úloze 12',
  new List<String>{'Obdélník: šířka $2\\cdot 1{,}5=3$ cm, výška $5$ cm, obsah $3\\cdot 5=15$ cm².','Trojúhelník: základna $2\\cdot(1{,}5+4)=11$ cm, výška $9-5=4$ cm, obsah $\\frac{11\\cdot 4}{2}=22$ cm².','Celkem $15+22=37$ cm².'},
  'A) $37$ cm²',
  2, 4, '3',
  new List<String>{'zs2','r7','planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7A 2017 – úloha 13',
  new List<String>{'Rovinný obrazec $ABCD$ je lichoběžník se základnami $AB$ a $DC$. Je narýsována úhlopříčka $AC$. Úhel při vrcholu $D$ má velikost $93^\\circ$, úhel $DCA$ má velikost $27^\\circ$ a úhel $ACB$ je pravý.','Jaká je velikost úhlu $\\beta$ při vrcholu $B$? Úhel $\\beta$ neměřte, ale vypočtěte.'},
  new List<String>{'A) menší než $55^\\circ$','B) $55^\\circ$','C) $57^\\circ$','D) $60^\\circ$','E) $63^\\circ$'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 220" font-family="sans-serif"> <polygon points="70,170 380,170 300,50 100,50" fill="none" stroke="#000" stroke-width="2.5"/> <line x1="70" y1="170" x2="300" y2="50" stroke="#000" stroke-width="2.5"/> <g fill="none" stroke="#000" stroke-width="1.6"> <path d="M93,79 A30,30 0 0,1 130,50"/> <path d="M254,50 A46,46 0 0,1 259,71"/> <path d="M346,170 A34,34 0 0,1 361,142"/> </g> <text x="106" y="94" font-size="15">93°</text> <text x="226" y="76" font-size="15">27°</text> <circle cx="295" cy="72" r="3.5" fill="#000"/> <text x="336" y="162" font-size="15" font-style="italic">β</text> <text x="60" y="192" font-size="16" font-style="italic">A</text> <text x="380" y="192" font-size="16" font-style="italic">B</text> <text x="300" y="40" font-size="16" font-style="italic">C</text> <text x="90" y="40" font-size="16" font-style="italic">D</text> </svg>',
  'lichobeznik.svg',
  'Lichoběžník ABCD s úhlopříčkou AC, úhlem 93 stupňů u D, úhlem 27 stupňů mezi DC a AC, pravým úhlem u C a úhlem beta u B.',
  'Výchozí obrázek k úloze 13',
  new List<String>{'Protože $DC \\parallel AB$, jsou úhly $DCA$ a $CAB$ střídavé, tedy $|\\angle CAB|=27^\\circ$.','V trojúhelníku $ABC$ platí $27^\\circ+90^\\circ+\\beta=180^\\circ$, tedy $\\beta=63^\\circ$.'},
  'E) $63^\\circ$',
  2, 4, '3',
  new List<String>{'zs2','r7','planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
