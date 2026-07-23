String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PCD24C0T03';
Integer YEAR = 2024;

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
  'CERMAT M9C 2024 – úloha 4.3',
  new List<String>{'Zjednodušte (výsledný výraz nesmí obsahovat závorky): $(c-7)\\cdot(c-7)-(c-5)\\cdot 3c+c\\cdot(c+c)=$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'$(c-7)^2=c^2-14c+49$; $(c-5)\\cdot 3c=3c^2-15c$; $c\\cdot(c+c)=2c^2$. Celkem $c^2-14c+49-(3c^2-15c)+2c^2=c^2-14c+49-3c^2+15c+2c^2=c+49$.'},
  '$c+49$',
  2, 4, '3',
  new List<String>{'zs2','r9','rovnice','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9C 2024 – úloha 5.1',
  new List<String>{'Řešte rovnici: $\\left(x+\\frac{1}{2}x\\right)\\cdot 2=\\left(x+\\frac{1}{6}x\\right)\\cdot 2+6$'},
  null,
  4,
  null,
  null,
  null,
  null,
  new List<String>{'Levá strana: $\\left(x+\\frac{1}{2}x\\right)\\cdot 2=3x$. Pravá strana: $\\left(x+\\frac{1}{6}x\\right)\\cdot 2+6=\\frac{7}{3}x+6$. Z rovnice $3x=\\frac{7}{3}x+6$ plyne $9x=7x+18$, tedy $2x=18$ a $x=9$.'},
  '$x=9$',
  2, 3, '2',
  new List<String>{'zs2','r9','rovnice','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9C 2024 – úloha 5.2',
  new List<String>{'Řešte rovnici: $\\frac{1}{2}\\cdot(x+2)-(x-2)^2=6-x^2$'},
  null,
  4,
  null,
  null,
  null,
  null,
  new List<String>{'$\\frac{1}{2}(x+2)-(x^2-4x+4)=6-x^2$, tj. $\\frac{x}{2}+1-x^2+4x-4=6-x^2$. Po odečtení $-x^2$ z obou stran: $\\frac{x}{2}+4x-3=6$, tedy $\\frac{9x}{2}=9$ a $x=2$.'},
  '$x=2$',
  2, 4, '3',
  new List<String>{'zs2','r9','rovnice','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9C 2024 – úloha 6',
  new List<String>{'Pravoúhlý lichoběžník $ABCD$ se základnami $AB$ a $CD$ a s pravým úhlem při vrcholu $D$ je úhlopříčkou $AC$ rozdělen na dva trojúhelníky $ABC$ a $ACD$. Pro délky stran platí: $|AB|=16$ cm, $|CD|=6$ cm. Obsah trojúhelníku $ABC$ je $64$ cm² (viz obrázek).','6.1 Vypočtěte výšku lichoběžníku $ABCD$. Výsledek uveďte v cm.','6.2 Vypočtěte obsah lichoběžníku $ABCD$. Výsledek uveďte v cm².'},
  null,
  4,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 480 270" font-family="sans-serif"> <polygon points="70,220 430,220 205,40 70,40" fill="none" stroke="#000" stroke-width="2"/> <polygon points="70,220 430,220 205,40" fill="#b9b9b9" stroke="#000"/> <line x1="70" y1="220" x2="205" y2="40" stroke="#000"/> <rect x="70" y="40" width="16" height="16" fill="none" stroke="#000"/> <text x="56" y="36" font-size="14" font-style="italic">D</text> <text x="205" y="32" font-size="14" font-style="italic" text-anchor="middle">C</text> <text x="56" y="236" font-size="14" font-style="italic">A</text> <text x="438" y="226" font-size="14" font-style="italic">B</text> <text x="140" y="32" font-size="12" text-anchor="middle">6 cm</text> <text x="250" y="240" font-size="12" text-anchor="middle">16 cm</text> <text x="245" y="150" font-size="13" text-anchor="middle">64 cm²</text> </svg>',
  'lichobeznik-ABCD.svg',
  'Pravoúhlý lichoběžník ABCD s pravým úhlem u D, úhlopříčkou AC a šedě vyznačeným trojúhelníkem ABC o obsahu 64 cm²; AB = 16 cm, CD = 6 cm.',
  'Pravoúhlý lichoběžník ABCD',
  new List<String>{'6.1 Trojúhelník $ABC$ má základnu $AB=16$ cm a jeho výška je zároveň výškou lichoběžníku $v$. Z obsahu $\\frac{1}{2}\\cdot 16\\cdot v=64$ plyne $8v=64$, tedy $v=8$ cm.','6.2 Obsah lichoběžníku: $S=\\frac{AB+CD}{2}\\cdot v=\\frac{16+6}{2}\\cdot 8=11\\cdot 8=88$ cm².'},
  '6.1: $8$ cm; 6.2: $88$ cm²',
  4, 6, '2',
  new List<String>{'zs2','r9','planimetrie','vypocet','slovni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
