String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PBD22C0T02';
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
  'CERMAT M5B 2022 – úloha 14',
  new List<String>{'Amélka, Viktorka a Zuzanka vytvářely stavby z kostek podle následujících pravidel: první sloupec stavby tvoří 1 tmavá kostka a dalších 5 sloupců je postaveno postupně ze 2, 3, 4, 3 a 2 bílých kostek. Poté se sloupce opakují ve stejném pořadí, ale po dostavění kteréhokoliv sloupce lze stavbu ukončit. Např. stavba na obrázku má celkem 23 sloupců, z nichž je 19 sloupců bílých a 4 tmavé.','14.1 Amélčina stavba má celkem 42 sloupců. Vypočtěte, kolik kostek (bílých i tmavých dohromady) obsahuje Amélčina stavba.','14.2 Viktorčina stavba má 58 bílých sloupců. Vypočtěte, kolik tmavých kostek obsahuje Viktorčina stavba.','14.3 Zuzančina stavba obsahuje celkem 156 kostek (bílých i tmavých dohromady). Vypočtěte, kolik sloupců má Zuzančina stavba.'},
  null,
  3,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 292 122" font-family="sans-serif"><rect x="20" y="74" width="18" height="18" fill="#9a9a9a" stroke="#000"/><rect x="38" y="74" width="18" height="18" fill="#ffffff" stroke="#000"/><rect x="38" y="56" width="18" height="18" fill="#ffffff" stroke="#000"/><rect x="56" y="74" width="18" height="18" fill="#ffffff" stroke="#000"/><rect x="56" y="56" width="18" height="18" fill="#ffffff" stroke="#000"/><rect x="56" y="38" width="18" height="18" fill="#ffffff" stroke="#000"/><rect x="74" y="74" width="18" height="18" fill="#ffffff" stroke="#000"/><rect x="74" y="56" width="18" height="18" fill="#ffffff" stroke="#000"/><rect x="74" y="38" width="18" height="18" fill="#ffffff" stroke="#000"/><rect x="74" y="20" width="18" height="18" fill="#ffffff" stroke="#000"/><rect x="92" y="74" width="18" height="18" fill="#ffffff" stroke="#000"/><rect x="92" y="56" width="18" height="18" fill="#ffffff" stroke="#000"/><rect x="92" y="38" width="18" height="18" fill="#ffffff" stroke="#000"/><rect x="110" y="74" width="18" height="18" fill="#ffffff" stroke="#000"/><rect x="110" y="56" width="18" height="18" fill="#ffffff" stroke="#000"/><rect x="146" y="74" width="18" height="18" fill="#9a9a9a" stroke="#000"/><rect x="164" y="74" width="18" height="18" fill="#ffffff" stroke="#000"/><rect x="164" y="56" width="18" height="18" fill="#ffffff" stroke="#000"/><rect x="182" y="74" width="18" height="18" fill="#ffffff" stroke="#000"/><rect x="182" y="56" width="18" height="18" fill="#ffffff" stroke="#000"/><rect x="182" y="38" width="18" height="18" fill="#ffffff" stroke="#000"/><rect x="200" y="74" width="18" height="18" fill="#ffffff" stroke="#000"/><rect x="200" y="56" width="18" height="18" fill="#ffffff" stroke="#000"/><rect x="200" y="38" width="18" height="18" fill="#ffffff" stroke="#000"/><rect x="200" y="20" width="18" height="18" fill="#ffffff" stroke="#000"/><rect x="218" y="74" width="18" height="18" fill="#ffffff" stroke="#000"/><rect x="218" y="56" width="18" height="18" fill="#ffffff" stroke="#000"/><rect x="218" y="38" width="18" height="18" fill="#ffffff" stroke="#000"/><rect x="236" y="74" width="18" height="18" fill="#ffffff" stroke="#000"/><rect x="236" y="56" width="18" height="18" fill="#ffffff" stroke="#000"/><line x1="20" y1="92" x2="254" y2="92" stroke="#000" stroke-width="2"/></svg>',
  'stavba-sloupce.svg',
  'Opakující se stavba ze sloupců kostek výšek 1, 2, 3, 4, 3, 2; první sloupec každé periody je tmavý.',
  'Perioda šesti sloupců (první sloupec tmavý)',
  new List<String>{'Jedna perioda má 6 sloupců (výšky 1, 2, 3, 4, 3, 2), tj. $1+2+3+4+3+2=15$ kostek, z toho 1 tmavý sloupec (1 tmavá kostka) a 5 bílých sloupců.','14.1 $42$ sloupců $=7$ celých period; $7\\cdot 15=105$ kostek.','14.2 $58$ bílých sloupců $=11\\cdot 5+3$, tj. 11 celých period a 3 bílé sloupce ve 12. periodě; tmavých sloupců je 12, tedy 12 tmavých kostek.','14.3 $156=10\\cdot 15+6$; v 11. periodě dají první tři sloupce $1+2+3=6$ kostek, celkem $60+3=63$ sloupců.'},
  '14.1: $105$ kostek; 14.2: $12$ tmavých kostek; 14.3: $63$ sloupců',
  4, 6, '3',
  new List<String>{'zs1','posloupnosti','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
