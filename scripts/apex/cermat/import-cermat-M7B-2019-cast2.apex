String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PBD19C0T02';
Integer YEAR = 2019;

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
  'CERMAT M7B 2019 – úloha 6',
  new List<String>{'Sestry Soňa a Táňa s kamarádkou Radkou pracovaly v létě na brigádě. Výplatu si rozdělily podle odpracované doby. Radka si vydělala 3 000 korun. Výplata obou sester dohromady a výplata Radky byly (v tomto pořadí) v poměru $5:2$. Výplata Soni byla o jednu osminu menší než výplata její sestry Táni.','6.1 Vypočtěte, kolik korun si vydělala všechna tři děvčata dohromady.','6.2 Vyjádřete v základním tvaru poměr výplat Soni a Táni (v tomto pořadí).','6.3 Vypočtěte, kolik korun si vydělala Soňa.'},
  null,
  4,
  null,
  null,
  null,
  null,
  new List<String>{'6.1 Sestry dohromady : Radka $=5:2$, Radka $=3000$ Kč, tedy sestry $\\frac{5}{2}\\cdot 3000=7500$ Kč. Celkem $7500+3000=10\\,500$ korun.','6.2 Soňa $=$ Táňa $-\\frac{1}{8}$ Táni $=\\frac{7}{8}$ Táni, poměr Soňa : Táňa $=7:8$.','6.3 Soňa a Táňa mají dohromady $7500$ Kč v poměru $7:8$ (15 dílů), Soňa $=\\frac{7}{15}\\cdot 7500=3500$ korun.'},
  '6.1: $10\\,500$ korun; 6.2: $7:8$; 6.3: $3\\,500$ korun',
  4, 6, '3',
  new List<String>{'zs2','r7','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M7B 2019 – úloha 7',
  new List<String>{'Na dně skleněné nádoby tvaru čtyřbokého hranolu je položena ocelová krychle. Krychle zakrývá čtvrtinu čtvercového dna nádoby. Nádoba s krychlí je po okraj naplněna vodou. Rozměry nádoby jsou v obrázku (podstava $6$ cm $\\times$ $6$ cm, výška $10$ cm). Tloušťku stěn nádoby zanedbáváme.','Vypočtěte v cm³ objem vody v nádobě s krychlí.'},
  null,
  4,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 340 380" font-family="sans-serif"> <polygon points="70,100 230,100 230,320 70,320" fill="none" stroke="#000" stroke-width="2"/> <polygon points="70,100 120,60 280,60 230,100" fill="none" stroke="#000" stroke-width="1.5"/> <polygon points="230,100 280,60 280,280 230,320" fill="none" stroke="#000" stroke-width="1.5"/> <line x1="120" y1="60" x2="120" y2="280" stroke="#000" stroke-width="1" stroke-dasharray="4 4"/> <line x1="120" y1="280" x2="280" y2="280" stroke="#000" stroke-width="1" stroke-dasharray="4 4"/> <line x1="120" y1="280" x2="70" y2="320" stroke="#000" stroke-width="1" stroke-dasharray="4 4"/> <polygon points="170,278 230,278 230,320 170,320" fill="#c6c6c6" stroke="#000"/> <polygon points="170,278 195,258 255,258 230,278" fill="#dcdcdc" stroke="#000"/> <polygon points="230,278 255,258 255,300 230,320" fill="#adadad" stroke="#000"/> <text x="30" y="215" font-size="15">10 cm</text> <text x="130" y="345" font-size="15">6 cm</text> <text x="240" y="330" font-size="15">6 cm</text> </svg>',
  'nadoba-krychle.svg',
  'Skleněná nádoba tvaru hranolu s podstavou 6 cm krát 6 cm a výškou 10 cm, na dně leží krychle.',
  'Nádoba s krychlí (schematicky)',
  new List<String>{'Objem nádoby $=6\\cdot 6\\cdot 10=360$ cm³. Krychle zakrývá čtvrtinu dna, tj. $\\frac{1}{4}\\cdot 36=9$ cm², hrana krychle je $3$ cm a její objem $3^3=27$ cm³. Objem vody $=360-27=333$ cm³.'},
  '$333$ cm³',
  3, 5, '3',
  new List<String>{'zs2','r7','stereometrie','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
