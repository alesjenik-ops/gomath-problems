String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PAD25C0T01';
Integer YEAR = 2025;

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
  'CERMAT M9A 2025 - uloha 15',
  new List<String>{'Priradte ke kazde uloze (15.1-15.3) odpovidajici vysledek (A-F).','15.1 Pri slavnostnim zahajeni souteze nastoupilo na hriste $10$ druzstev po $11$ hracich a vsichni organizatori souteze. Dohromady tak nastoupilo $200$ osob. Kolik procent osob nastoupenych na hristi tvorili organizatori?','15.2 Souteze se ucastnilo $20$ triclennych druzstev. V kazdem z nich byl alespon jeden muz a alespon jedna zena. Druzstev s jednim muzem bylo ctyrikrat vice nez druzstev s jednou zenou. Kolik procent soutezicich tvorily zeny?','15.3 Na atletickem preboru soutezil kazdy atlet prave v jedne ze tri disciplin. V hodu ostepem soutezilo $12$ atletU. SkokanU bylo o $40\\,\\%$ mene nez bezcU, ale o $50\\,\\%$ vice nez osteparU. Kolik procent vsech soutezicich atletU tvorili bezci?'},
  new List<String>{'A) $40\\,\\%$','B) $45\\,\\%$','C) $50\\,\\%$','D) $55\\,\\%$','E) $60\\,\\%$','F) vice nez $60\\,\\%$'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'15.1 HracU $10\\cdot 11=110$, organizatorU $200-110=90$; $\\frac{90}{200}=45\\,\\%$ -> B.','15.2 Celkem $60$ soutezicich. Druzstev s jednou zenou (dva muzi) je $x$, s jednim muzem (dve zeny) $4x$; $5x=20$, $x=4$. Zen $2\\cdot 16+1\\cdot 4=36$; $\\frac{36}{60}=60\\,\\%$ -> E.','15.3 OsteparU $12$, skokanU $1{,}5\\cdot 12=18$, bezcU $18:0{,}6=30$; celkem $60$, bezcU $\\frac{30}{60}=50\\,\\%$ -> C.'},
  '15.1: B ($45\\,\\%$); 15.2: E ($60\\,\\%$); 15.3: C ($50\\,\\%$)',
  6, 9, '4',
  new List<String>{'zs2','r9','procenta','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M9A 2025 - uloha 16',
  new List<String>{'Vytvarime tmave a svetle obrazce tvaru ctverce. Kazdy obsahuje jeden bily ctverec obklopeny pasem z nekolika shodnych obdelnicku o rozmerech $2$ cm a $3$ cm. U tmavych obrazcU je pas z obdelnicku vzdy uzsi (obdelnicky prilehaji kratsi stranou), u svetlych sirsi (prilehaji delsi stranou). Obrazec popisujeme tremi cisly: pocet obdelnicku, delka strany bileho ctverce a delka strany celeho obrazce (v cm). Napr. tmave obrazce: $(4;1;5)$, $(8;4;8)$, $(12;7;11)$; svetly obrazec: $(8;1;7)$.','16.1 Delka strany tmaveho obrazce je $20$ cm. Urcete pocet obdelnicku v obrazci.','16.2 Delka strany tmaveho i svetleho obrazce je $23$ cm. Urcete, o kolik se lisi pocet obdelnicku v techto dvou obrazcich.','16.3 Tmavy i svetly obrazec maji stejny pocet obdelnicku, ale delky stran bilych ctvercU se v techto obrazcich lisi o $10$ cm. Urcete pocet obdelnicku v tmavem obrazci.'},
  null,
  4,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 480 200" font-family="sans-serif"> <rect x="40" y="30" width="150" height="150" fill="#8f8f8f" stroke="#000"/> <rect x="70" y="60" width="90" height="90" fill="#fff" stroke="#000"/> <text x="115" y="196" font-size="12" text-anchor="middle">tmavy obrazec (uzsi pas)</text> <rect x="280" y="20" width="170" height="170" fill="#e2e2e2" stroke="#000"/> <rect x="325" y="65" width="80" height="80" fill="#fff" stroke="#000"/> <text x="365" y="196" font-size="12" text-anchor="middle">svetly obrazec (sirsi pas)</text> </svg>',
  'obrazce-pas.svg',
  'Bily ctverec obklopeny pasem obdelnicku: tmavy obrazec s uzsim pasem a svetly obrazec s sirsim pasem (schematicky).',
  'Schematicky nakres tmaveho a svetleho obrazce',
  new List<String>{'U tmaveho obrazce je strana $s=w+4$ (pas siroky $2$ cm) a pocet obdelnicku $n=\\frac{s^2-w^2}{6}=\\frac{(w+4)^2-w^2}{6}=\\frac{8w+16}{6}$. U svetleho je $s=w+6$ (pas siroky $3$ cm) a $n=\\frac{(w+6)^2-w^2}{6}=2w+6$.','16.1 Tmavy: $w=20-4=16$, $n=\\frac{8\\cdot 16+16}{6}=\\frac{144}{6}=24$.','16.2 Tmavy: $w=19$, $n=\\frac{8\\cdot 19+16}{6}=28$; svetly: $w=17$, $n=2\\cdot 17+6=40$; rozdil $40-28=12$.','16.3 Z $n=\\frac{8w_t+16}{6}$ plyne $w_t=\\frac{3n-8}{4}$, ze svetleho $w_s=\\frac{n-6}{2}$; rozdil $w_t-w_s=\\frac{n+4}{4}=10$, tedy $n=36$.'},
  '16.1: $24$ obdelnicku; 16.2: o $12$ obdelnicku; 16.3: $36$ obdelnicku',
  4, 8, '4',
  new List<String>{'zs2','r9','planimetrie','modelovani','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
