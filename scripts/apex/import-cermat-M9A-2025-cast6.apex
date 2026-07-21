String SRC   = 'CERMAT – Jednotná přijímací zkouška 2025, 1. řádný termín (M9A)';
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
  'CERMAT 2025 M9A · úloha 10',
  new List<String>{'V rovině leží bod $B$ a přímky $p$, $q$, které se protínají v bodě $C$ (viz obrázek).','Body $B$, $C$ jsou vrcholy trojúhelníku $ABC$. Na přímce $p$ leží výška $v_c$ na stranu $c$ a na přímce $q$ leží těžnice $t_c$ na stranu $c$. Sestrojte vrchol $A$ trojúhelníku $ABC$, označte ho a trojúhelník narýsujte.'},
  null,
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 472 305"><path d="M4 4L5 4L5 23L4 23Z" style="fill:#000000"/><path d="M467 4L468 4L468 23L467 23Z" style="fill:#000000"/><path d="M4 300L5 300L5 301L4 301Z" style="fill:#000000"/><path d="M4 300L5 300L5 301L4 301Z" style="fill:#000000"/><path d="M5 300L467 300L467 301L5 301Z" style="fill:#000000"/><path d="M467 300L468 300L468 301L467 301Z" style="fill:#000000"/><path d="M467 300L468 300L468 301L467 301Z" style="fill:#000000"/><path d="M4 23L5 23L5 300L4 300Z" style="fill:#000000"/><path d="M467 23L468 23L468 300L467 300Z" style="fill:#000000"/><path d="M400 195L394 200M400 200L394 195M260 53L296 270M291 40L193 281" style="fill:none;stroke:#000000;stroke-width:2"/><text x="52" y="20" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">V rovině leží bod</text><text x="98" y="20" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">B</text><text x="125" y="20" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">a přímky</text><text x="153" y="20" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">p</text><text x="158" y="20" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">,</text><text x="164" y="20" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">q</text><text x="231" y="20" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">, které se protínají v bodě</text><text x="299" y="20" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">C</text><text x="305" y="20" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">.</text><text x="398" y="215" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">B</text><text x="256" y="66" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">p</text><text x="296" y="54" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">q</text><text x="278" y="101" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">C</text></svg>',
  'obr.svg',
  'Bod B a přímky p, q protínající se v bodě C.',
  '',
  new List<String>{'Výška $v_c$ i těžnice $t_c$ vycházejí z vrcholu $C$; obě leží na daných přímkách procházejících $C$.','Strana $c=AB$ je kolmá k výšce $v_c$ (přímka $p$). Střed strany $AB$ leží na těžnici $t_c$ (přímka $q$).','Sestrojíme přímku $AB$ kolmou k $p$ procházející $B$; její průsečík s $q$ je střed strany $c$, a vrchol $A$ je obraz $B$ v tomto středu.'},
  'Strana $AB\\perp p$ prochází bodem $B$; střed $AB$ je průsečík této přímky s $q$; vrchol $A$ je obraz $B$ podle tohoto středu.',
  2, 5, '4',
  new List<String>{'zs2','r9','konstrukce','geometrie','planimetrie','konstrukcni','rysovani','bez-kontextu'},
  'M9PAD25C0T01', 2025
);

System.debug('Vytvořeno úloh: '+c.created);
