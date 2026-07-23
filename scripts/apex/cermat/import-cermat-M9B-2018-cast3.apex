String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PBD18C0T02';
Integer YEAR = 2018;

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
  'CERMAT M9B 2018 – úloha 7',
  new List<String>{'Nad dvěma stranami trojúhelníku $ABC$ jsou sestrojeny čtverce. Obsah čtverce nad stranou $BC$ je $25$ cm². Velikost výšky $v_c$ na stranu $AB$ je $3$ cm. Pata $P$ výšky $v_c$ dělí stranu $AB$ v poměru $2:1$. Strana $AC$ je delší než strana $BC$.','7.1 Vypočtěte v cm délku strany $AB$.','7.2 Vypočtěte v cm² obsah čtverce nad stranou $AC$.'},
  null,
  4,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="-30 0 550 340" font-family="sans-serif"> <polygon points="120,300 360,300 280,180" fill="none" stroke="#000" stroke-width="2"/> <polygon points="360,300 280,180 400,100 480,220" fill="none" stroke="#000" stroke-width="1.6"/> <polygon points="120,300 280,180 160,20 0,140" fill="none" stroke="#000" stroke-width="1.6"/> <line x1="280" y1="180" x2="280" y2="300" stroke="#000" stroke-width="1" stroke-dasharray="4 4"/> <rect x="280" y="288" width="12" height="12" fill="none" stroke="#000" stroke-width="1"/> <text x="292" y="250" font-size="13">3 cm</text> <text x="384" y="165" font-size="13">25 cm²</text> <text x="108" y="316" font-size="14" font-style="italic">A</text> <text x="360" y="316" font-size="14" font-style="italic">B</text> <text x="272" y="172" font-size="14" font-style="italic">C</text> <text x="276" y="316" font-size="14" font-style="italic">P</text> </svg>',
  'ctverce-trojuhelnik.svg',
  'Trojúhelník ABC se čtverci sestrojenými nad stranami BC (obsah 25 cm²) a AC; výška vc z vrcholu C na stranu AB s patou P.',
  'Výchozí obrázek k úloze 7',
  new List<String>{'7.1 Obsah čtverce nad $BC$ je $25$ cm², tedy $|BC|=5$ cm. V pravoúhlém trojúhelníku $BPC$ je $|CP|=v_c=3$ cm, proto $|BP|=\\sqrt{5^2-3^2}=4$ cm. Protože $AC>BC$, je pata $P$ blíže k $B$, takže $|AP|:|BP|=2:1$, tedy $|AP|=8$ cm. $|AB|=|AP|+|BP|=8+4=12$ cm.','7.2 V pravoúhlém trojúhelníku $APC$ je $|AP|=8$ cm, $|CP|=3$ cm, proto $|AC|^2=8^2+3^2=73$. Obsah čtverce nad $AC$ je $|AC|^2=73$ cm².'},
  '7.1: $12$ cm; 7.2: $73$ cm²',
  3, 7, '4',
  new List<String>{'zs2','r9','planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9B 2018 – úloha 8.1',
  new List<String>{'Doplňte do rámečku ($\\square$) takové číslo, aby platila rovnost:','$80$ dm³ $-\\;\\square\\cdot 400$ cm³ $=20$ dm³'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$80$ dm³ $-20$ dm³ $=60$ dm³ se musí rovnat $\\square\\cdot 400$ cm³. Protože $400$ cm³ $=0{,}4$ dm³, je $\\square=60:0{,}4=150$.'},
  '$150$',
  1, 2, '3',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9B 2018 – úloha 8.2',
  new List<String>{'Doplňte do rámečku ($\\square$) takové číslo, aby platila rovnost:','$(5+\\square)$ minut $=\\frac{2}{5}$ hodiny $-\\frac{1}{4}$ hodiny'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$\\frac{2}{5}$ hodiny $-\\frac{1}{4}$ hodiny $=\\frac{8}{20}-\\frac{5}{20}=\\frac{3}{20}$ hodiny $=\\frac{3}{20}\\cdot 60=9$ minut. Tedy $5+\\square=9$, $\\square=4$.'},
  '$4$',
  1, 2, '3',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9B 2018 – úloha 9.1',
  new List<String>{'V pravoúhlém trojúhelníku $ABC$ (pravý úhel u vrcholu $C$) sestrojte a popište výšky $v_a$, $v_b$, $v_c$.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 380 330" font-family="sans-serif"> <polygon points="80,90 300,300 300,90" fill="none" stroke="#000" stroke-width="2"/> <rect x="284" y="90" width="16" height="16" fill="none" stroke="#000" stroke-width="1"/> <line x1="300" y1="90" x2="195" y2="200" stroke="#000" stroke-width="1" stroke-dasharray="4 4"/> <text x="182" y="80" font-size="14" font-style="italic">va</text> <text x="305" y="200" font-size="14" font-style="italic">vb</text> <text x="236" y="135" font-size="14" font-style="italic">vc</text> <text x="62" y="88" font-size="14" font-style="italic">A</text> <text x="304" y="312" font-size="14" font-style="italic">B</text> <text x="304" y="84" font-size="14" font-style="italic">C</text> </svg>',
  'pravouhly-trojuhelnik.svg',
  'Pravoúhlý trojúhelník ABC s pravým úhlem u vrcholu C; vyznačeny výšky va, vb (splývají s odvěsnami) a vc (kolmice z C na přeponu AB).',
  'Výchozí obrázek k úloze 9.1',
  new List<String>{'Výška $v_c$ z vrcholu $C$ je kolmice z $C$ na přeponu $AB$. Výška $v_a$ (z vrcholu $A$ na stranu $a=BC$) splývá s odvěsnou $AC$ a výška $v_b$ (z vrcholu $B$ na stranu $b=AC$) splývá s odvěsnou $BC$, neboť úhel u $C$ je pravý.'},
  'Výšky pravoúhlého trojúhelníku: $v_c$ je kolmice z $C$ na $AB$; $v_a$ splývá s odvěsnou $AC$ a $v_b$ s odvěsnou $BC$ (viz obrázek v klíči).',
  1, 2, '2',
  new List<String>{'zs2','r9','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
