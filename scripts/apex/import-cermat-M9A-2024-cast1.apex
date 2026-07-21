String SRC   = 'CERMAT – Jednotná přijímací zkouška 2024, 1. řádný termín (M9A)';
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
  'CERMAT 2024 M9A · úloha 1',
  new List<String>{'Pět švadlen splní danou zakázku za $24$ hodin (pracují stejným tempem). Za jakou dobu splní o polovinu větší zakázku čtyři švadleny?'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'Práce na zakázku $=5\\cdot24=120$ švadlenohodin; o polovinu větší zakázka $=180$ švadlenohodin.','Čtyři švadleny: $\\frac{180}{4}=45$ hodin.'},
  '$45$ hodin',
  1, 2, '3',
  new List<String>{'zs2','r9','aritmetika','slovni','modelovani','bez-kalkulacky','bezny-zivot'},
  'M9PAD24C0T01', 2024
);
c.add(
  'CERMAT 2024 M9A · úloha 2',
  new List<String>{'Skleněné těžítko má tvar rotačního válce s poloměrem podstavy $10\\ \\mathrm{cm}$ a výškou $12\\ \\mathrm{cm}$. Uvnitř je část z modrého skla, také tvaru válce, s poloměrem podstavy $5\\ \\mathrm{cm}$ a výškou $8\\ \\mathrm{cm}$ (viz obrázek). Vnější část je z čirého skla.','Vypočítejte objem čirého skla v těžítku (zaokrouhlete na desítky $\\mathrm{cm}^3$, $\\pi\\doteq3{,}14$).'},
  null,
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 459 184"><path d="M4 4L455 4L455 5L4 5Z" style="fill:#000000"/><path d="M201 104C201 108 213 111 229 111C245 111 257 108 257 104L257 158C257 162 245 165 229 165C213 165 201 162 201 158L201 104Z" style="fill:#d9d9d9"/><path d="M201 104C201 100 213 97 229 97C245 97 257 100 257 104C257 108 245 111 229 111C213 111 201 108 201 104Z" style="fill:#e8e8e8"/><path d="M257 104C257 108 245 111 229 111C213 111 201 108 201 104C201 100 213 97 229 97C245 97 257 100 257 104L257 158C257 162 245 165 229 165C213 165 201 162 201 158L201 104M273 92C273 98 253 103 228 103C204 103 184 98 184 92C184 86 204 81 228 81C253 81 273 86 273 92L273 169C273 175 253 180 228 180C204 180 184 175 184 169L184 92" style="fill:none;stroke:#000000;stroke-width:2"/></svg>',
  'obr.svg',
  'Skleněné těžítko tvaru válce (poloměr 10 cm, výška 12 cm) s vnitřním modrým válcem (poloměr 5 cm, výška 8 cm).',
  '',
  new List<String>{'Objem těžítka $\\pi\\cdot10^2\\cdot12=1\\,200\\pi\\ \\mathrm{cm}^3$; objem modrého skla $\\pi\\cdot5^2\\cdot8=200\\pi\\ \\mathrm{cm}^3$.','Čiré sklo $1\\,000\\pi\\doteq3\\,140\\ \\mathrm{cm}^3$.'},
  '$3\\,140\\ \\mathrm{cm}^3$',
  2, 4, '3',
  new List<String>{'zs2','r9','stereometrie','geometrie','vypocet','slovni','bez-kalkulacky','bezny-zivot'},
  'M9PAD24C0T01', 2024
);
c.add(
  'CERMAT 2024 M9A · úloha 3',
  new List<String>{'Vypočítejte a výsledek zapište zlomkem v základním tvaru.','3.1 \\quad $\\left(2:\\dfrac{3}{2}\\right):\\dfrac{1}{2}+\\left(\\dfrac{5}{6}:\\dfrac{3}{4}\\right):\\dfrac{2}{3}=$','3.2 \\quad $\\dfrac{\\frac{13}{10}-1{,}4}{\\frac{2}{15}+\\frac{1}{6}}=$'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'3.1: $\\left(\\frac{4}{3}\\right):\\frac{1}{2}+\\left(\\frac{10}{9}\\right):\\frac{2}{3}=\\frac{8}{3}+\\frac{5}{3}=\\frac{13}{3}$.','3.2: čitatel $\\frac{13}{10}-1{,}4=-\\frac{1}{10}$; jmenovatel $\\frac{2}{15}+\\frac{1}{6}=\\frac{3}{10}$; $-\\frac{1}{10}:\\frac{3}{10}=-\\frac{1}{3}$.'},
  '3.1: $\\frac{13}{3}$; 3.2: $-\\frac{1}{3}$',
  4, 5, '3',
  new List<String>{'zs2','r9','zlomky','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PAD24C0T01', 2024
);
c.add(
  'CERMAT 2024 M9A · úloha 4',
  new List<String>{'4.1 Zjednodušte (bez závorek): $\\left(a-\\dfrac{a}{4}\\right)^2=$','4.2 Rozložte na součin podle vzorce: $9a^2-16=$','4.3 Zjednodušte a rozložte na součin vytýkáním: $(c-5)\\cdot(2-3c)-(c-2c)\\cdot3c-c\\cdot7=$'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'4.1: $\\left(\\frac{3a}{4}\\right)^2=\\frac{9a^2}{16}$.','4.2: $9a^2-16=(3a-4)(3a+4)$.','4.3: $(-3c^2+17c-10)+3c^2-7c=10c-10=10(c-1)$.'},
  '4.1: $\\frac{9a^2}{16}$; 4.2: $(3a-4)(3a+4)$; 4.3: $10(c-1)$',
  4, 5, '3',
  new List<String>{'zs2','r9','vyrazy','algebra','vypocet','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PAD24C0T01', 2024
);
c.add(
  'CERMAT 2024 M9A · úloha 5',
  new List<String>{'Řešte rovnice.','5.1 \\quad $-2\\cdot(x+4)-3\\cdot(x+1)^2=x\\cdot(2-3x)$','5.2 \\quad $6-\\dfrac{3-2y}{5}\\cdot2=4y$'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'5.1: $-2x-8-3(x^2+2x+1)=2x-3x^2\\Rightarrow -3x^2-8x-11=2x-3x^2\\Rightarrow -11=10x\\Rightarrow x=-1{,}1$.','5.2: vynásobením $5$: $30-2(3-2y)=20y\\Rightarrow 24+4y=20y\\Rightarrow 24=16y\\Rightarrow y=\\frac{3}{2}$.'},
  '5.1: $x=-1{,}1$; 5.2: $y=\\frac{3}{2}$',
  4, 6, '3',
  new List<String>{'zs2','r9','rovnice','linearni-rovnice','algebra','vypocet','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PAD24C0T01', 2024
);

System.debug('Vytvořeno úloh: '+c.created);
