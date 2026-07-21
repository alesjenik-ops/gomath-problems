String SRC   = 'CERMAT – Jednotná přijímací zkouška 2021, 2. řádný termín (M9B)';
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
  'CERMAT 2021 M9B · úloha 8',
  new List<String>{'Trojúhelníky $AB_1C_1$ a $AB_2C_2$ jsou pravoúhlé (pravý úhel při vrcholech $B_1$, $B_2$). Společný vrchol A dělí úsečky $B_1B_2$ a $C_1C_2$ ve stejném poměru: $|AB_1|:|AB_2|=|AC_1|:|AC_2|=1:3$. Úsečka $C_1C_2$ měří $20\\ \\mathrm{cm}$. Odvěsna $B_1C_1$ měří $4\\ \\mathrm{cm}$.','8.1 \\quad Vypočtěte v cm délku přepony $AC_1$ menšího trojúhelníku.','8.2 \\quad Vypočtěte v cm obvod menšího trojúhelníku ($AB_1C_1$).','8.3 \\quad Vypočtěte v cm$^2$ obsah většího trojúhelníku ($AB_2C_2$).'},
  null,
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 470 150"><path d="M4 4L466 4L466 5L4 5Z" style="fill:#000000"/><path d="M431 98C431 89 438 82 446 82" style="fill:none;stroke:#000000;stroke-width:1"/><path d="M439 91C439 90 439 90 440 90C440 90 441 90 441 91C441 92 440 92 440 92C439 92 439 92 439 91Z" style="fill:#000000"/><path d="M368 98L368 127L390 98L368 98M446 98L446 25L390 98L446 98" style="fill:none;stroke:#000000;stroke-width:2"/><text x="366" y="95" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">B</text><text x="371" y="97" font-size="9" fill="#000" text-anchor="middle" font-family="sans-serif">1</text><text x="365" y="142" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">C</text><text x="371" y="144" font-size="9" fill="#000" text-anchor="middle" font-family="sans-serif">1</text><text x="446" y="112" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">B</text><text x="451" y="114" font-size="9" fill="#000" text-anchor="middle" font-family="sans-serif">2</text><text x="445" y="23" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">C</text><text x="451" y="24" font-size="9" fill="#000" text-anchor="middle" font-family="sans-serif">2</text><text x="354" y="119" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">4 cm</text><text x="394" y="113" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">A</text></svg>',
  'obr.svg',
  'Dva pravoúhlé trojúhelníky AB1C1 a AB2C2 se společným vrcholem A; menší má odvěsnu B1C1 = 4 cm, úsečka C1C2 = 20 cm, poměr stran 1:3.',
  '',
  new List<String>{'8.1: bod A dělí úsečku $C_1C_2$ v poměru $1:3$, tedy $AC_1=\\frac{1}{4}\\cdot20=5\\ \\mathrm{cm}$.','8.2: v pravoúhlém trojúhelníku $AB_1C_1$ je přepona $AC_1=5$, odvěsna $B_1C_1=4$, druhá odvěsna $AB_1=\\sqrt{5^2-4^2}=3\\ \\mathrm{cm}$; obvod $=5+4+3=12\\ \\mathrm{cm}$.','8.3: trojúhelníky jsou podobné s poměrem $1:3$; obsah menšího $=\\frac{1}{2}\\cdot3\\cdot4=6\\ \\mathrm{cm}^2$, obsah většího $=6\\cdot3^2=54\\ \\mathrm{cm}^2$.'},
  '8.1: $5\\ \\mathrm{cm}$; 8.2: $12\\ \\mathrm{cm}$; 8.3: $54\\ \\mathrm{cm}^2$',
  3, 6, '4',
  new List<String>{'zs2','r9','planimetrie','geometrie','pomer','vypocet','bez-kalkulacky'},
  'M9PBD21C0T02', 2021
);
c.add(
  'CERMAT 2021 M9B · úloha 9',
  new List<String>{'V rovině leží přímka $c$ a polopřímka AX (viz obrázek). Bod A je vrchol rovnoramenného pravoúhlého trojúhelníku ABC. Vrchol B leží na polopřímce AX, vrchol C leží na přímce $c$. Pravý úhel je buď při vrcholu A, nebo při vrcholu B.','9.1 \\quad Sestrojte trojúhelník ABC s pravým úhlem při vrcholu A.','9.2 \\quad Sestrojte trojúhelník ABC s pravým úhlem při vrcholu B. Vrcholy B, C označte písmeny.'},
  null,
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 350 233"><path d="M45 208L346 208M45 204L45 212M278 212L278 204M318 4L4 113" style="fill:none;stroke:#000000;stroke-width:2"/><text x="45" y="227" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">A</text><text x="278" y="227" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">X</text><text x="314" y="19" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">c</text></svg>',
  'obr.svg',
  'V rovině leží přímka c (stoupající zleva doprava) a vodorovná polopřímka AX s krajním bodem A a bodem X.',
  '',
  new List<String>{'Jde o konstrukční úlohu; rovnoramenný pravoúhlý trojúhelník má obě odvěsny stejně dlouhé.','9.1 (pravý úhel při A): vrchol C je průsečík přímky $c$ s kolmicí k AX vedenou bodem A; protože $|AB|=|AC|$, naneseme délku $|AC|$ na polopřímku AX a získáme vrchol B.','9.2 (pravý úhel při B): platí $BC\\perp AX$ a $|AB|=|BC|$; vrchol C leží na přímce $c$, vrchol B na polopřímce AX. Konstrukci lze provést pomocí úhlu $45^\\circ$ při vrcholu A (přepona AC). Hodnotí se přesnost a úplnost konstrukce.'},
  'Konstrukce dvou rovnoramenných pravoúhlých trojúhelníků $ABC$ (pravý úhel při A, resp. při B); $B$ na polopřímce AX, $C$ na přímce $c$.',
  3, 7, '4',
  new List<String>{'zs2','r9','konstrukce','planimetrie','geometrie','rysovani','bez-kontextu'},
  'M9PBD21C0T02', 2021
);

System.debug('Vytvořeno úloh: '+c.created);
