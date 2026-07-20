String SRC   = 'Matematika - Zelený';
String STYPE = 'Jiné';

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
  void add(String name,List<String> zad,List<String> opts,Integer ln,String svg,String fn,String alt,String cap,List<String> solp,String ans,Decimal pts,Decimal mins,String diff,List<String> codes){
    if(have.contains(name))return;
    Id d=(svg!=null)?sv(name,fn,svg):null;
    Math_Problem__c mp=new Math_Problem__c(Name=name,Status__c='Publikováno',Visibility__c='Organizace',Language__c='cs',Current_Version_Number__c=1);insert mp;
    String cj=content(zad,d,alt,cap,opts,ln); String sj=solution(solp);
    String aj=JSON.serialize(new Map<String,Object>{'type'=>'Text','value'=>ans});
    Problem_Version__c pub=new Problem_Version__c(Problem__c=mp.Id,Version_Number__c=1,Is_Published__c=true,Published_At__c=Datetime.now(),Title__c=name,Content_JSON__c=cj,Solution_JSON__c=sj,Answer_JSON__c=aj,Answer_Type__c='Text',Points__c=pts,Expected_Time_Min__c=mins,Difficulty__c=diff,Source__c=src,Source_Type__c=stype,License__c='Jiná',Search_Text__c=GoMathContent.buildSearchText(name,cj,sj,null));
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
  'Zelený H10 – konstrukce trojúhelníku z těžnic',
  new List<String>{'Dvě různoběžky $t_b$ a $t_c$ svírají úhel $60^\\circ$. Jejich průsečík je označen $T$. Mimo obě přímky leží bod $Z$ (viz obrázek).','Sestrojte trojúhelník $ABC$, jehož těžnice $t_b=t_c=6$ cm, bod $T$ je těžištěm trojúhelníku a bod $Z$ vnitřním bodem trojúhelníku $ABC$.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 500 400" font-family="sans-serif"> <line x1="60" y1="230" x2="450" y2="230" stroke="#000" stroke-width="1.5"/> <text x="458" y="234" font-size="16" font-style="italic">t<tspan font-size="11" dy="4">b</tspan></text> <line x1="160" y1="386" x2="345" y2="66" stroke="#000" stroke-width="1.5"/> <text x="350" y="60" font-size="16" font-style="italic">t<tspan font-size="11" dy="4">c</tspan></text> <text x="240" y="252" font-size="16" font-style="italic">T</text> <text x="332" y="178" font-size="22" text-anchor="middle">+</text> <text x="332" y="160" font-size="16" text-anchor="middle" font-style="italic">Z</text> <text x="250" y="205" font-size="14" text-anchor="middle">60°</text> </svg>',
  'teznice-tz.svg',
  'Dvě různoběžky t_b a t_c protínající se v bodě T pod úhlem 60 stupňů a bod Z ležící mimo obě přímky.',
  'Výchozí obrázek k úloze 10',
  new List<String>{'Těžiště dělí těžnici v poměru $2:1$ od vrcholu. Na přímce $t_b$ leží vrchol $B$ s $|BT|=\\frac{2}{3}\\cdot6=4$ cm, na přímce $t_c$ vrchol $C$ s $|CT|=4$ cm; orientaci volíme tak, aby bod $Z$ ležel uvnitř trojúhelníku. Střed strany $AC$ leží na $t_b$ ve vzdálenosti $2$ cm od $T$ na opačné straně než $B$, obdobně střed $AB$ na $t_c$; z nich se dopočte vrchol $A$. Trojúhelník $ABC$ má obě těžnice délky $6$ cm.'},
  'Konstrukce trojúhelníku $ABC$ s těžištěm $T$: $|BT|=|CT|=4$ cm na přímkách $t_b$, $t_c$ (těžnice $6$ cm, těžiště je dělí v poměru $2:1$), orientace zvolena tak, aby byl $Z$ vnitřním bodem (viz obrázek v klíči).',
  2, 6, '4',
  new List<String>{'zs2','r9','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
