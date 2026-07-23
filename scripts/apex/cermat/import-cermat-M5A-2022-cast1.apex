String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PAD22C0T01';
Integer YEAR = 2022;

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
  'CERMAT M5A 2022 – úloha 1.1',
  new List<String>{'Vypočtěte: $(2\\cdot 243-18):(10\\cdot 165\\cdot 0+20:5)=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Čitatel: $2\\cdot 243-18=486-18=468$. Jmenovatel: $10\\cdot 165\\cdot 0+20:5=0+4=4$. Podíl $468:4=117$.'},
  '$117$',
  2, 2, '2',
  new List<String>{'zs1','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5A 2022 – úloha 1.2',
  new List<String>{'Vypočtěte: $4\\cdot(540-360)-(8\\cdot 180-5\\cdot 180)=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$4\\cdot 180-(1440-900)=720-540=180$.'},
  '$180$',
  2, 2, '2',
  new List<String>{'zs1','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5A 2022 – úloha 2',
  new List<String>{'Na číselné ose je zobrazeno devět bodů oddělujících osm stejných dílků. Body $A$, $B$, $C$, $D$ představují čtyři čísla. V bodě $C$ je číslo $48$, které je trojnásobkem čísla v bodě $B$.','2.1 Určete číslo v bodě $A$.','2.2 Určete číslo v bodě $D$.'},
  null,
  2,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 130" font-family="sans-serif"><line x1="20" y1="80" x2="540" y2="80" stroke="#000" stroke-width="2"/><polygon points="540,80 528,74 528,86" fill="#000"/><line x1="40" y1="72" x2="40" y2="88" stroke="#000" stroke-width="2"/><line x1="100" y1="72" x2="100" y2="88" stroke="#000" stroke-width="2"/><line x1="160" y1="72" x2="160" y2="88" stroke="#000" stroke-width="2"/><line x1="220" y1="72" x2="220" y2="88" stroke="#000" stroke-width="2"/><line x1="280" y1="72" x2="280" y2="88" stroke="#000" stroke-width="2"/><line x1="340" y1="72" x2="340" y2="88" stroke="#000" stroke-width="2"/><line x1="400" y1="72" x2="400" y2="88" stroke="#000" stroke-width="2"/><line x1="460" y1="72" x2="460" y2="88" stroke="#000" stroke-width="2"/><line x1="520" y1="72" x2="520" y2="88" stroke="#000" stroke-width="2"/><text x="100" y="106" font-size="16" text-anchor="middle" font-style="italic">A</text><text x="160" y="106" font-size="16" text-anchor="middle" font-style="italic">B</text><text x="280" y="106" font-size="16" text-anchor="middle" font-style="italic">C</text><text x="400" y="106" font-size="16" text-anchor="middle" font-style="italic">D</text><text x="280" y="64" font-size="15" text-anchor="middle">48</text></svg>',
  'osa.svg',
  'Číselná osa s devíti body (osm stejných dílků); body A, B, C, D a nad bodem C číslo 48.',
  'Číselná osa s body A, B, C, D',
  new List<String>{'Bod $B$: $48:3=16$. Body $B$ a $C$ jsou od sebe dva dílky, takže jeden dílek $=(48-16):2=16$.','2.1 Bod $A$ je o jeden dílek vlevo od $B$: $16-16=0$.','2.2 Bod $D$ je o dva dílky vpravo od $C$: $48+2\\cdot 16=80$.'},
  '2.1: $0$; 2.2: $80$',
  4, 4, '2',
  new List<String>{'zs1','aritmetika','porozumeni','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5A 2022 – úloha 3.1',
  new List<String>{'Neznámé číslo je větší než 1. Když ho vynásobíme samo sebou, dostaneme číslo o 17 menší než devítinásobek čísla 9.','Určete neznámé číslo.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Devítinásobek čísla 9 je $9\\cdot 9=81$; o 17 méně je $81-17=64$. Hledáme číslo, jehož druhá mocnina je $64$, a které je větší než 1: $8\\cdot 8=64$, tedy číslo je $8$.'},
  '$8$',
  2, 3, '2',
  new List<String>{'zs1','aritmetika','vypocet','slovni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5A 2022 – úloha 3.2',
  new List<String>{'V každé bedýnce je 6 lahví se sirupem. Každá lahev obsahuje půl litru sirupu. Ve všech bedýnkách je celkem 321 litrů sirupu.','Určete počet bedýnek se sirupem.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'V jedné bedýnce je $6\\cdot 0{,}5=3$ litry sirupu. Počet bedýnek $=321:3=107$.'},
  '$107$ bedýnek',
  2, 3, '2',
  new List<String>{'zs1','aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
