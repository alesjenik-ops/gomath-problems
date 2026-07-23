String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PCD21C0T03';
Integer YEAR = 2021;

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
  'CERMAT M9C 2021 – úloha 16',
  new List<String>{'Trojúhelníkové obrazce se podle vzoru sestavují z tmavých šestiúhelníků a bílých trojúhelníků. Šestiúhelník se skládá ze 6 shodných tmavých trojúhelníků. Jednotlivé řady obrazce jsou očíslovány vždy od nejkratší (řada 1 u dolního vrcholu) po nejdelší. Na obrázku je třetí nejmenší obrazec se 7 řadami.','Obrazec má 19 řad. Určete počet','16.1 bílých trojúhelníků v 9. řadě,','16.2 tmavých trojúhelníků v 16. řadě,','16.3 tmavých šestiúhelníků v celém obrazci.'},
  null,
  3,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 380 310" font-family="sans-serif"><g stroke="#000" stroke-width="1.2" fill="#fff"><polygon points="30,20 74,20 52,58"/><polygon points="74,20 118,20 96,58" fill="#c9c9c9"/><polygon points="118,20 162,20 140,58"/><polygon points="162,20 206,20 184,58" fill="#c9c9c9"/><polygon points="206,20 250,20 228,58"/><polygon points="250,20 294,20 272,58" fill="#c9c9c9"/><polygon points="294,20 338,20 316,58"/><polygon points="52,58 96,58 74,20" fill="#c9c9c9"/><polygon points="96,58 140,58 118,20" fill="#c9c9c9"/><polygon points="140,58 184,58 162,20" fill="#c9c9c9"/><polygon points="184,58 228,58 206,20" fill="#c9c9c9"/><polygon points="228,58 272,58 250,20" fill="#c9c9c9"/><polygon points="272,58 316,58 294,20" fill="#c9c9c9"/><polygon points="52,58 96,58 74,96" fill="#c9c9c9"/><polygon points="96,58 140,58 118,96" fill="#c9c9c9"/><polygon points="140,58 184,58 162,96" fill="#c9c9c9"/><polygon points="184,58 228,58 206,96" fill="#c9c9c9"/><polygon points="228,58 272,58 250,96" fill="#c9c9c9"/><polygon points="272,58 316,58 294,96" fill="#c9c9c9"/><polygon points="74,96 118,96 96,58" fill="#c9c9c9"/><polygon points="118,96 162,96 140,58"/><polygon points="162,96 206,96 184,58" fill="#c9c9c9"/><polygon points="206,96 250,96 228,58"/><polygon points="250,96 294,96 272,58" fill="#c9c9c9"/><polygon points="74,96 118,96 96,134"/><polygon points="118,96 162,96 140,134" fill="#c9c9c9"/><polygon points="162,96 206,96 184,134"/><polygon points="206,96 250,96 228,134" fill="#c9c9c9"/><polygon points="250,96 294,96 272,134"/><polygon points="96,134 140,134 118,96" fill="#c9c9c9"/><polygon points="140,134 184,134 162,96" fill="#c9c9c9"/><polygon points="184,134 228,134 206,96" fill="#c9c9c9"/><polygon points="228,134 272,134 250,96" fill="#c9c9c9"/><polygon points="96,134 140,134 118,172" fill="#c9c9c9"/><polygon points="140,134 184,134 162,172" fill="#c9c9c9"/><polygon points="184,134 228,134 206,172" fill="#c9c9c9"/><polygon points="228,134 272,134 250,172" fill="#c9c9c9"/><polygon points="118,172 162,172 140,134" fill="#c9c9c9"/><polygon points="162,172 206,172 184,134"/><polygon points="206,172 250,172 228,134" fill="#c9c9c9"/><polygon points="118,172 162,172 140,211"/><polygon points="162,172 206,172 184,211" fill="#c9c9c9"/><polygon points="206,172 250,172 228,211"/><polygon points="140,211 184,211 162,172" fill="#c9c9c9"/><polygon points="184,211 228,211 206,172" fill="#c9c9c9"/><polygon points="140,211 184,211 162,249" fill="#c9c9c9"/><polygon points="184,211 228,211 206,249" fill="#c9c9c9"/><polygon points="162,249 206,249 184,211" fill="#c9c9c9"/><polygon points="162,249 206,249 184,287"/></g></svg>',
  'obrazce.svg',
  'Trojúhelníkový obrazec se 7 řadami: tmavé šestiúhelníky (po šesti trojúhelnících) a bílé trojúhelníky, řady číslovány zdola.',
  'Trojúhelníkový obrazec se 7 řadami (třetí nejmenší)',
  new List<String>{'Bílé trojúhelníky jsou jen v lichých řadách: v 1. řadě je 1, ve 3. řadě 2, v 5. řadě 3 – v každé další liché řadě o jeden více.','16.1 Řada 9 je pátou lichou řadou, proto obsahuje $5$ bílých trojúhelníků.','Tmavé trojúhelníky tvoří šestiúhelníky; v sudé řadě s číslem $2k$ je jich $3k$ (2. řada 3, 4. řada 6, 6. řada 9 …).','16.2 Řada 16 $=2\\cdot 8$, tedy $3\\cdot 8=24$ tmavých trojúhelníků.','Šestiúhelníky jsou uspořádány po dvojicích řad: v řadách 2–3 je 1, v řadách 4–5 jsou 2, …, v $k$-té dvojici řad $k$ šestiúhelníků. Obrazec s 19 řadami má 9 dvojic řad.','16.3 Celkem $1+2+3+\\dots+9=45$ tmavých šestiúhelníků (což je $45\\cdot 6=270$ tmavých trojúhelníků).'},
  '16.1: $5$ bílých trojúhelníků; 16.2: $24$ tmavých trojúhelníků; 16.3: $45$ tmavých šestiúhelníků',
  4, 8, '4',
  new List<String>{'zs2','r9','posloupnosti','argumentace','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
