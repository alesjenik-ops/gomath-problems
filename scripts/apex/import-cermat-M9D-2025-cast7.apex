String SRC   = 'CERMAT – Jednotná přijímací zkouška 2025, 2. náhradní termín (M9D)';
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
  'CERMAT 2025 M9D · úloha 16',
  new List<String>{'Hřiště má tvar obdélníku $KLMN$. Po obvodu vede trasa se stanovišti $A$, $B$, $C$, $D$ (viz obrázek); úsečky $AC$ a $BD$ jsou rovnoběžné se stranami a šedý obrazec je čtverec. Úsek $AKB$ měří $45\\ \\mathrm{m}$, úsek $BLC$ měří $39\\ \\mathrm{m}$ a úsek $CMD$ měří $30\\ \\mathrm{m}$.','16.1 Vypočtěte v metrech rozdíl mezi délkami úseček $BK$ a $BL$.','16.2 Vypočtěte délku kratší strany hřiště.','16.3 Vypočtěte obvod hřiště.','16.4 Vypočtěte vzdálenost stanoviště $D$ od vrcholu $N$.'},
  null,
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 188 137"><path d="M183 4L184 4L184 23L183 23Z" style="fill:#000000"/><path d="M183 23L184 23L184 39L183 39Z" style="fill:#000000"/><path d="M183 39L184 39L184 55L183 55Z" style="fill:#000000"/><path d="M183 55L184 55L184 70L183 70Z" style="fill:#000000"/><path d="M183 70L184 70L184 86L183 86Z" style="fill:#000000"/><path d="M183 86L184 86L184 105L183 105Z" style="fill:#000000"/><path d="M183 105L184 105L184 124L183 124Z" style="fill:#000000"/><path d="M100 31L157 31L157 88L100 88Z" style="fill:#d9d9d9"/><path d="M15 31L157 31L157 130L15 130Z" style="fill:none;stroke:#7f7f7f;stroke-width:2"/><path d="M100 31L100 130M15 88L157 88" style="fill:none;stroke:#7f7f7f;stroke-width:1"/><path d="M14 88L14 31C14 31 14 30 15 30L100 30C100 30 101 31 101 31C101 32 100 32 100 32L15 32L16 31L16 88C16 88 15 89 15 89C14 89 14 88 14 88M100 28C102 28 103 30 103 31C103 33 102 34 100 34C98 34 97 33 97 31C97 30 98 28 100 28Z" style="fill:#000000"/><path d="M14 88L14 130C14 131 14 131 15 131L100 131C100 131 101 131 101 130C101 130 100 130 100 130L15 130L16 130L16 88C16 88 15 87 15 87C14 87 14 88 14 88M18 88C18 86 17 85 15 85C13 85 12 86 12 88C12 90 13 91 15 91C17 91 18 90 18 88Z" style="fill:#000000"/><path d="M157 88L157 130C157 131 157 131 157 131L100 131C99 131 99 131 99 130C99 130 99 130 100 130L157 130L156 130L156 88C156 88 156 87 157 87C157 87 157 88 157 88M154 88C154 86 155 85 157 85C158 85 160 86 160 88C160 90 158 91 157 91C155 91 154 90 154 88M100 133C98 133 97 132 97 130C97 129 98 127 100 127C102 127 103 129 103 130C103 132 102 133 100 133Z" style="fill:#000000"/><text x="15" y="29" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">K</text><text x="160" y="29" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">N</text><text x="101" y="28" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">A</text><text x="7" y="94" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">B</text><text x="167" y="94" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">D</text></svg>',
  'obr.svg',
  'Obdélníkové hřiště KLMN se stanovišti A, B, C, D na obvodu, úsečkami AC a BD rovnoběžnými se stranami a vyznačeným šedým čtvercem.',
  '',
  new List<String>{'Označme $AK=LC=a$, $BK=b$; z rovnoběžností a délek úseků: $a+b=45$, $(w-b)+a=39$, $(h-a)+(w-b)=30$, kde $w$, $h$ jsou strany. Odtud $2b-w=6$ a $w+h=75$.','16.1: $BK-BL=b-(w-b)=2b-w=6\\ \\mathrm{m}$.','16.2 a 16.3: ze čtvercové podmínky vychází $w=30\\ \\mathrm{m}$ (kratší strana), $h=45\\ \\mathrm{m}$; obvod $2(30+45)=150\\ \\mathrm{m}$.','16.4: $DN=BK=b=18\\ \\mathrm{m}$.'},
  '16.1: $6\\ \\mathrm{m}$; 16.2: $30\\ \\mathrm{m}$; 16.3: $150\\ \\mathrm{m}$; 16.4: $18\\ \\mathrm{m}$',
  4, 7, '4',
  new List<String>{'zs2','r9','geometrie','planimetrie','argumentace','pocetni','bez-kalkulacky','bezny-zivot'},
  'M9PDD25C0T04', 2025
);

System.debug('Vytvořeno úloh: '+c.created);
